
# Usage:  ./upload.sh elasticsearch-hostname-or-ip

version="$(cat version)"
for file in `ls generated/elasticsearch/component/*.json`
do
  fieldset=`echo $file | cut -d/ -f4 | cut -d. -f1 | tr A-Z a-z`
  component_name="ecs_${version}_${fieldset}"
  api="_component_template/${component_name}"

  curl  -XPUT -k "$1:9200/$api" --header "Content-Type: application/json" -d @"$file"
  echo ""
done
