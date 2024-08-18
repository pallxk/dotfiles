// https://manual.nssurge.com/scripting/common.html
// https://manual.nssurge.com/scripting/http-request.html


const map = {
  // 容器服务 ACK
  ack: 'https://cs.console.aliyun.com/',
  cs: 'https://cs.console.aliyun.com/',
  // 容器镜像服务
  acr: 'https://cr.console.aliyun.com/cn-shanghai/instances',
  cr: 'https://cr.console.aliyun.com/cn-shanghai/instances',
  // 内容安全
  cts: 'https://yundun.console.aliyun.com/?p=cts',
  // 数据库备份DBS
  dbs: 'https://dbs.console.aliyun.com/',
  // 数据传输服务
  dts: 'https://dtsnew.console.aliyun.com/sync/cn-shanghai',
  dtsnew: 'https://dtsnew.console.aliyun.com/sync/cn-shanghai',
  // 短信服务
  dysms: 'https://dysms.console.aliyun.com/overview',
  // 块存储 EBS
  ebs: 'https://ebs.console.aliyun.com/overview',
  // 弹性容器实例
  eci: 'https://eci.console.aliyun.com/',
  // 云服务器
  ecs: 'https://ecs.console.aliyun.com/home',
  // 消息队列Kafka版
  kafka: 'https://kafka.console.aliyun.com/',
  kafkanext: 'https://kafkanext.console.aliyun.com/overview',
  // 密钥管理服务3.0
  kms: 'https://yundun.console.aliyun.com/?p=kms',
  // 瑶池数据库
  kvstore: 'https://kvstore.console.aliyun.com/Redis/dashboard/cn-shanghai',
  // 移动开发平台 mPaaS
  mpaas: 'https://mpaas.console.aliyun.com/',
  // 对象存储 OSS
  oss: 'https://oss.console.aliyun.com/overview',
  // 云数据库PolarDB
  polardb: 'https://polardb.console.aliyun.com/overview',
  // 云数据库RDS
  rds: 'https://rdsnext.console.aliyun.com/dashboard/cn-shanghai',
  rdsnext: 'https://rdsnext.console.aliyun.com/dashboard/cn-shanghai',
  // 负载均衡 SLB
  slb: 'https://slb.console.aliyun.com/',
  // 专有网络
  vpc: 'https://vpc.console.aliyun.com/',
  // 高速通道 - 专有网络对等连接 - VPC互联
  vpc2vpc: 'https://expressconnect.console.aliyun.com/peerconnection/cn-shanghai/vpc2vpc',
  // 网络互联 - VPN - VPN网关
  vpn: 'https://vpc.console.aliyun.com/vpn/cn-shanghai/vpns',
  // Web应用防火墙3.0
  waf: 'https://yundun.console.aliyun.com/?p=wafnew',
  // 瑶池数据库
  yaochi: 'https://yaochi.console.aliyun.com/overview',
}

const url = new URL($request.url)
const target = map[url.hostname]

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
