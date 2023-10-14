$BaseUrl = $Env:BASEURL
$Token = $Env:TOKEN
$Sn = $Env:SNID

$Response = Invoke-RestMethod -URI "$($BaseUrl)?tokenId=$($Token)&sn=$($Sn)"

$SnapshotData = $Response.result

$pv = $SnapshotData.powerdc1 + $SnapshotData.powerdc2
# Might need to do some calculation to include feedinpower in this number
$lp = $SnapshotData.acpower

$OutputJson = ConvertTo-Json @{
    'pv'=$pv
    'lp'=$lp
    'gp'=$SnapshotData.feedinpower
    'bp'=$SnapshotData.batPower
    'bc'=$SnapshotData.soc
}

$fileName = "docs/snapshot.json"
$OutputJson | Set-Content -Path $fileName
