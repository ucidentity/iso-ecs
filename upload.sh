
# Usage:  ./upload.sh  elasticsearch-hostname-or-ip

# Prompt for username and password
printf "Username: "
read USERNAME
stty -echo
printf "Password: "
read PASSWORD
stty echo
printf "\n"

version="$(cat version)"
for file in `ls generated/elasticsearch/composable/component/*.json`
do
  fieldset=`echo $file | cut -d/ -f5 | cut -d. -f1 | tr A-Z a-z`
  component_name="ecs_${version}_${fieldset}"
  api="_component_template/${component_name}"



# echo "$file => $api"
curl  -k -u $USERNAME:$PASSWORD -XPUT "$1:9200/$api" --header "Content-Type: application/json" -d @"$file"
done
