# Run the 'az ad app create' command and capture the JSON output
subscriptionId="40d18884-9235-4a11-89f7-ffc8e6acd5bf"
resourceGroupName="infra-rg"
output=$(az ad app create --display-name myApp3)
client_id=$(echo $output | jq -r '.appId')

sp_create_output=$( az ad sp create --id $client_id)
assigneeObjectId=$(echo $sp_create_output| jq -r '.id')
roleAssignment=$(az role assignment create --role contributor --subscription $subscriptionId --assignee-object-id  $assigneeObjectId --assignee-principal-type ServicePrincipal --scope /subscriptions/$subscriptionId/resourceGroups/$resourceGroupName)

echo "set federated credentials in azure portal "