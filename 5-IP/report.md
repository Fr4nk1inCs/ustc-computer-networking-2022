# 计算机网络实验 5

<center>
    傅申 PB20000051
</center>

> 使用提供的包

## 2. A look at the captured trace

![image-20221113151905514](/home/fushen/.config/Typora/typora-user-images/image-20221113151905514.png)

1. IP 地址为 `192.168.1.102`.
2. 上层协议为 `ICMP (1)`
3. 报头有 `20` 字节, 报文总共 `84` 字节, 因此载荷有 `64` 字节.
4. Flags 字段为 0, 因此没有分片.

![image-20221113160331121](/home/fushen/.config/Typora/typora-user-images/image-20221113160331121.png)

5. 标识 `Identification` 和首部检验和 `Header Checksum` 每次都改变.

6. 保持不变的字段:

   - 版本号 `Version`
   - 首部长度 `Header Length`
   - 区分服务 `Differentiated Services`
   - 上层协议 `Protocol`
   - 源地址 `Source Address`
   - 目的地址 `Destination Address`

   必须保持不变的字段:

   - 版本号 `Version`: 因为所有的数据报都使用 IPv4.
   - 首部长度 `Header Length`: 因为数据报都是无选项的, 首部长度应该为 20 字节.
   - 区分服务 `Differentiated Services`: 因为所有数据报使用的是同样的服务类型.
   - 协议 `Protocol`: 因为所有数据报都是 ICMP 报文.
   - 源地址 `Source Address`: 因为我们在查看所有相同源地址的报文.
   - 目的地址 `Destination Address`: 因为所有报文都被发往同一个地址.

   必须发生改变的字段:

   - 标识 `Identification`: 因为不同的包的标识不同.
   - 首部校验和 `Header Checksum`: 因为其他字段的改变必然导致校验和的改变.

7. 每发送一个 ICMP Echo 报文, 标识字段都加 1.

![image-20221113164225608](/home/fushen/.config/Typora/typora-user-images/image-20221113164225608.png)

8. 标识字段为 `0x9d7c`, TTL 字段为 `255`.
9. 标识字段每次都改变, 因为不同数据报有不同的标识. TTL 字段保持不变, 因为路由器处理数据报时 TTL 才减 1.

## Fragmentation

![image-20221113170022067](/home/fushen/.config/Typora/typora-user-images/image-20221113170022067.png)

10. 发生了分片.

![image-20221113170151718](/home/fushen/.config/Typora/typora-user-images/image-20221113170151718.png)

11. 标志 `Flags` 为 `0x1`, 说明发生了分片. 片偏移为 `0`, 说明这是第一个片. 数据报的长度为 `1500` 字节.

![image-20221113170431143](/home/fushen/.config/Typora/typora-user-images/image-20221113170431143.png)

12. 片偏移为 `1480` 说明这不是第一个片. 标识为 `0x0` 说明没有其他的片.
13. 数据报长度 `Total Length`, 标志 `Flags`, 片偏移 `Fragment Offset` 和首部校验和 `Header Checksum` 发生了变化.

![image-20221113171059953](/home/fushen/.config/Typora/typora-user-images/image-20221113171059953.png)

14. 总共分为了三片 (编号分别为 216, 217 和 218)
15. 数据报长度 `Total Length`, 标志 `Flags`, 片偏移 `Fragment Offset` 和首部校验和 `Header Checksum` 发生了变化.