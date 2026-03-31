# Small Steps MQTT Firewall Rule Script
# 此脚本将在 Windows 防火墙中添加允许 1883(TCP) 和 8083(WebSocket) 的入站规则

$RuleName = "SmallSteps MQTT Broker"
$MQTTPort = "1883"
$WSPort = "8083"

Write-Host "Checking for existing rule: $RuleName"
$Rule = Get-NetFirewallRule -DisplayName $RuleName -ErrorAction SilentlyContinue

if ($Rule) {
    Write-Host "Rule already exists. Updating..."
    Set-NetFirewallRule -DisplayName $RuleName -Action Allow -Direction Inbound -Protocol TCP -LocalPort @($MQTTPort, $WSPort)
    Write-Host "Rule updated successfully."
} else {
    Write-Host "Creating new rule..."
    New-NetFirewallRule -DisplayName $RuleName -Action Allow -Direction Inbound -Protocol TCP -LocalPort @($MQTTPort, $WSPort)
    Write-Host "Rule created successfully."
}

Write-Host "Done! Please test MQTT connection now."
