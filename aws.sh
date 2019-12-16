#!/bin/bash

for service in $(cat aws_services.txt)
  do
      /usr/local/bin/aws "$service" help | egrep 'describe-|get-|list-' | tr -cd "[:print:]\n" | sed 's/+o//g' | sed 's/ //g' > /tmp/"$service"-output

      for command in $(cat /tmp/"$service"-output)
        do
          cmd="/usr/local/bin/aws $service $command --generate-cli-skeleton output"
          $cmd > outputs/"$service"-"$command".json
        done
  done
