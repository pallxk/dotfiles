// https://manual.nssurge.com/scripting/common.html
// https://manual.nssurge.com/scripting/http-request.html

const region = $argument || 'cn-north-1'

const map = {
  // EC2
  ec2: `https://${region}.console.amazonaws.cn/ec2/home?region=${region}`,
  // EC2 - Instances - Launch an instance
  ec2l: `https://console.amazonaws.cn/ec2/home?region=${region}#LaunchInstances:`,
  // EC2 - Internet Gateways
  igw: `https://${region}.console.amazonaws.cn/vpcconsole/home?region=${region}#igws:`,
  // EC2 - Load Balancers
  lb: `https://${region}.console.amazonaws.cn/ec2/home?region=${region}#LoadBalancers:`,
  // EC2 - NAT Gateways
  nat: `https://${region}.console.amazonaws.cn/vpcconsole/home?region=${region}#NATGateways:`,
  natgw: `https://${region}.console.amazonaws.cn/vpcconsole/home?region=${region}#NATGateways:`,
  // VPC - Managed prefix lists
  pl: `https://${region}.console.amazonaws.cn/vpcconsole/home?region=${region}#ManagedPrefixLists:`,
  // S3
  s3: `https://${region}.console.amazonaws.cn/s3/home?region=${region}`,
  // VPC - Security Groups
  sg: `https://${region}.console.amazonaws.cn/vpcconsole/home?region=${region}#SecurityGroups:`,
  // VPC
  vpc: `https://${region}.console.amazonaws.cn/vpcconsole/home?region=${region}#vpcs:`,
}

const url = new URL($request.url)

// vpc -> https://${region}.console.amazonaws.cn/vpcconsole/home?region=${region}#vpcs:
// vpc.aws -> https://${region}.console.amazonaws.cn/vpcconsole/home?region=${region}#vpcs:
const target = map[url.hostname.split('.')[0]]

if (target) {
  $done({
    response: {
      status: 302,
      headers: {
        'Location': target,
      },
    },
  })
} else {
  $done({})
}
