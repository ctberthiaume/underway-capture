#!/usr/bin/env python3
import click
import pendulum
import random
import socket
import time


@click.command()
@click.option('--port', 'udp_port', default=1234, type=int, show_default=True,
    help='UDP destination port')
def main(udp_port):
    udp_host = '255.255.255.255'  # broadcast address
    print('broadcasting simulated data on port {} '.format(str(udp_port)))

    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)

    for msg in km_feed():
        sock.sendto(msg, (udp_host, udp_port))
        print('{}: sent message, {} bytes'.format(pendulum.now('UTC').to_rfc3339_string(), len(msg)))
        time.sleep(1)


def km_feed():
    while True:
        t = pendulum.now('UTC')
        t = t.add(minutes=-1)
        lines = ''
        lines += '{} bar1   {:.4f} mbar\r\n'.format(
            km_timestamp(t), random.uniform(900, 1100))
        lines += '{} uthsl {:.4f} {:.4f} {:.4f} {:.4f}\r\n'.format(
            km_timestamp(t.add(microseconds=8000)), random.uniform(10, 30), random.uniform(0, 6), random.uniform(0, 35), random.uniform(10, 30))
        lines += '$GPDTM,W84,,00.0000,N,00.0000,E,,W84*41\r\n'
        lines += '$GPGGA,003029.00,2118.9043,N,15752.6526,W,2,7,0.8,27,M,,M,,*78\r\n'
        lines += '{} rbgm3 024723 00 978906.152511\r\n'.format(
            km_timestamp(t.add(microseconds=300000)))
        lines += '{} rwd1  10 233   0.0  52.5 208.3  10.0  81.3 \r\n'.format(
            km_timestamp(t.add(microseconds=360000)))
        lines += '$GPDTM,W84,,00.0000,N,00.0000,E,,W84*41\r\n'
        lines += '{} rwd2  10 233   0.0  52.5 208.3  10.0  81.3 \r\n'.format(
            km_timestamp(t.add(microseconds=360000)))
        lines += '{} flor {:.6f}\r\n'.format(
            km_timestamp(t.add(microseconds=460000)), random.uniform(0, 78))
        lines += '$GPGLL,2118.9043,N,15752.6526,W,003029.00,A,D*71\r\n'
        lines += '$GPVTG,47.3,T,37.7,M,0.0,N,0.0,K,D*25\r\n'
        lines += '$GPZDA,003029.00,17,06,2017,00,00*6A\r\n'
        lines += '{} met  0.000 28.680  50.900 28.470 24.766  3.758 -0.246  1.097  1.099  0.000 5040.000  1.016 11.9 235.0 11.9   83.3     {:.03f}  0.000\r\n'.format(
            km_timestamp(t.add(microseconds=960000)), random.uniform(0, 4000))
        lines += '$GPDTM,W84,,00.0000,N,00.0000,E,,W84*41\r\n'
        yield lines.encode('utf-8')


def km_timestamp(dt):
    return dt.format('YYYY DDD HH mm ss SSS')


if __name__ == '__main__':
    main()
