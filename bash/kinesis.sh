#!/usr/bin/env bash
# Read data from Kinesis event stream
function downloadFromKinesis() {
    if [[ "$1" == "" || "$2" == ""  || "$3" == "" ]]; then
        echo 'Usage: ./kinesis [STREAM NAME] [AWS PROFILE] [FILE EXTENSION] [LIMIT ?]'
        echo '       FILE EXTNESION can be "avro", "json" or "text'
        exit 1
    fi

    stream=$1
    profile=$2
    extension=$3

    function parse_creds() {
      local creds=$1
      local attribute=.Credentials.$2

      echo $creds | jq $attribute | tr -d '"'
    }

    echo "Reading from stream '$stream' using AWS profile '$profile'"

    shard_id=$(aws kinesis describe-stream \
                 --stream-name ${stream} \
                 --output text \
                 --query 'StreamDescription.Shards[0].ShardId' \
                 --profile ${profile})

    if [[ -z "$shard_id" ]]; then
        echo 'No shard ID found!'
        exit 1
    fi

    shard_iterator=$(aws kinesis get-shard-iterator \
                       --stream-name ${stream} \
                       --shard-id ${shard_id} \
                       --shard-iterator-type LATEST \
                       --query 'ShardIterator' \
                       --profile ${profile})

    if [[ -z "$shard_iterator" ]]; then
        echo 'No shard iterator found!'
        exit 1
    fi

    limit=$3 || '10'

    data=$(aws kinesis get-records \
      --shard-iterator ${shard_iterator} \
      --limit $limit \
      --output json \
      --query 'Records' \
      --profile ${profile} \
    | jq -r '.[]."Data"')

    echo "shard_id=$shard_id"
    echo "shard_iterator=$shard_iterator"
    echo "data=$data"

    if [[ -z "$data" ]]; then
        echo 'No data found!'
        exit 1
    fi

    echo $data

    directory="json/$shard_id"
    echo "Deleting directory $directory"
    rm -rf $directory
    mkdir -p $directory
    pushd .
    cd $directory

    j=0
    for i in $data
        do
            echo $i \
            | base64 -d \
            > output-$stream-`date +%s`.$extension
            j=$(($j+1))
        done
    popd

    echo "Done storing JSON from $stream into files."
}
