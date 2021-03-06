
--服务器节点表
DROP TABLE IF EXISTS `nodes`;
CREATE TABLE `nodes` (
  `node_id` int NOT NULL AUTO_INCREMENT COMMENT 'key',
  `node_name` varchar(50) COMMENT '节点名称',
  `host_name` varchar(30) COMMENT 'host name',
  `hosts` varchar(100) COMMENT 'hosts, 多个以逗号隔开',
  `ip` varchar(20) COMMENT '服务器IP',
  `ip_public` varchar(20) COMMENT '服务器外网IP',
  `user_name` varchar(50) COMMENT '用户名',
  `password` varchar(255) COMMENT '密码',
  `status` tinyint COMMENT '状态',
  `comment` varchar(200)  COMMENT '备注',
  `create_time` timestamp default now() COMMENT '创建时间',
  `update_time` timestamp default now() COMMENT '修改时间',
  `is_deleted` tinyint default 0 COMMENT '是否删除， 0=未删除，1=已删除',
   PRIMARY KEY (`node_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8;
create index `idx_nodes_host_name` on `nodes`(`host_name`);
create index `idx_nodes_ip` on `nodes`(`ip`);
create index `idx_nodes_create_time` on `nodes`(`create_time`);


--服务表
DROP TABLE IF EXISTS `services`;
CREATE TABLE `services` (
  `service_id` int NOT NULL AUTO_INCREMENT COMMENT 'key',
  `service_name` varchar(50) COMMENT '服务名称',
  `start_cmd` varchar(50) COMMENT '启动命令',
  `stop_cmd` varchar(50) COMMENT '停止命名',
  `node_id` int COMMENT '所属节点ID',
  `status` tinyint COMMENT '当前状态',
  `comment` varchar(200)  COMMENT '备注',
  `create_time` timestamp default now() COMMENT '创建时间',
  `update_time` timestamp default now() COMMENT '修改时间',
  `is_deleted` tinyint default 0 COMMENT '是否删除， 0=未删除，1=已删除',
   PRIMARY KEY (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8;
create index `idx_services_node_id` on `services`(`node_id`);
create index `idx_services_service_name` on `services`(`service_name`);


-- 服务监控详情
DROP TABLE IF EXISTS `service_health`;
CREATE TABLE `service_health` (
  `service_health_id` int NOT NULL AUTO_INCREMENT COMMENT 'key',
  `service_id` int COMMENT '服务ID',
  `service_name` varchar(50) COMMENT '服务名称',
  `node_id` int COMMENT '所属节点ID',
  `status` tinyint COMMENT '当前状态',
  `comment` varchar(200)  COMMENT '备注',
  `create_time` timestamp default now() COMMENT '创建时间',
  `update_time` timestamp default now() COMMENT '修改时间',
  `is_deleted` tinyint default 0 COMMENT '是否删除， 0=未删除，1=已删除',
   PRIMARY KEY (`service_health_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8;
create index `idx_service_health_node_id` on `services`(`node_id`);
create index `idx_service_health_service_name` on `services`(`service_name`);


-- 服务gc详情
DROP TABLE IF EXISTS `service_gc_detail`;
CREATE TABLE `service_gc_detail` (
  `gcinfo_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'key',
  `service_id` int COMMENT '服务id',
  `service_name` varchar(50) COMMENT '服务名称',
  `pid` decimal(10,2) COMMENT '进程号',
  `S0C` decimal(10,2) COMMENT '年轻代中第一个survivor（幸存区）的容量 (字节)',
  `S1C` decimal(10,2) COMMENT '年轻代中第二个survivor（幸存区）的容量 (字节)',
  `S0U` decimal(10,2) COMMENT '年轻代中第一个survivor（幸存区）目前已使用空间 (字节)',
  `S1U` decimal(10,2) COMMENT '年轻代中第二个survivor（幸存区）目前已使用空间 (字节)',
  `EC` decimal(10,2) COMMENT '年轻代中Eden（伊甸园）的容量 (字节)',
  `EU` decimal(10,2) COMMENT '年轻代中Eden（伊甸园）目前已使用空间 (字节)',
  `OC` decimal(10,2) COMMENT 'Old代的容量 (字节)',
  `OU` decimal(10,2) COMMENT 'Old代目前已使用空间 (字节)',
  `MC` decimal(10,2) COMMENT '方法区容量(字节)',
  `MU` decimal(10,2) COMMENT '方法区已使用大小(字节)',
  `CCSC` decimal(10,2) COMMENT '压缩类空间大小',
  `CCSU` decimal(10,2) COMMENT '压缩类空间使用大小',
  `YGC` int COMMENT '从应用程序启动到采样时年轻代中gc次数',
  `YGCT` decimal(10,2) COMMENT '从应用程序启动到采样时年轻代中gc所用时间(s)',
  `FGC` int COMMENT '从应用程序启动到采样时old代(全gc)gc次数',
  `FGCT` decimal(10,2) COMMENT '从应用程序启动到采样时old代(全gc)gc所用时间(s)',
  `GCT` decimal(10,2) COMMENT '从应用程序启动到采样时gc用的总时间(s)',
  `create_time` timestamp default now() COMMENT '采样时间',
   PRIMARY KEY (`gcinfo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8;
create index `idx_service_gc_detail_service_id` on `service_gc_detail`(`service_id`);
create index `idx_service_gc_detail_service_name` on `service_gc_detail`(`service_name`);
create index `idx_service_gc_detail_pid` on `service_gc_detail`(`pid`);
create index `idx_service_gc_detail_create_time` on `service_gc_detail`(`create_time`);



DROP TABLE IF EXISTS `node_memory`;
CREATE TABLE `node_memory` (
  `node_memory_id` int NOT NULL AUTO_INCREMENT COMMENT 'key',
  `node_id` int COMMENT '所属节点ID',
  `total` int COMMENT '总内存，kb',
  `used` int COMMENT '已使用内存，kb',
  `free` int COMMENT '空闲内存，kb',
  `shared` int COMMENT 'shared内存，kb',
  `buff_cache` int COMMENT 'cache， buff使用的内存，kb',
  `available` int COMMENT 'available ，kb',
  `swap_total` int COMMENT 'swap总内存，kb',
  `swap_used` int COMMENT 'swap已使用内存，kb',
  `swap_free` int COMMENT 'swap空闲内存，kb',
  `create_time` timestamp default now() COMMENT '采样时间',
   PRIMARY KEY (`node_memory_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8;
create index `idx_nodes_memory_node_id` on `node_memory`(`node_id`);


node_memory
node_cpu
node_disk