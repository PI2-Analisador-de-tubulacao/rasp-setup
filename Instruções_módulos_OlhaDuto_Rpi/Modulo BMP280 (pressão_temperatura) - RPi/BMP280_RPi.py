# Código em Python para BMP280

#Referência: https://github.com/ControlEverythingCommunity/BMP280/commit/ff98c9596a73f80384cf4008119903de83e3a40f

import smbus
import time

# Pegar I2C bus
bus = smbus.SMBus(1)

# BMP280 endereço, 0x76(118)
# Ler dados de 0x88(136), 24 bytes
b1 = bus.read_i2c_block_data(0x76, 0x88, 24)

# Converte os dados
# Coeficientes de temperatura
dig_T1 = b1[1] * 256 + b1[0]
dig_T2 = b1[3] * 256 + b1[2]
if dig_T2 > 32767 :
    dig_T2 -= 65536
dig_T3 = b1[5] * 256 + b1[4]
if dig_T3 > 32767 :
    dig_T3 -= 65536

# Coeficientes de pressão
dig_P1 = b1[7] * 256 + b1[6]
dig_P2 = b1[9] * 256 + b1[8]
if dig_P2 > 32767 :
    dig_P2 -= 65536
dig_P3 = b1[11] * 256 + b1[10]
if dig_P3 > 32767 :
    dig_P3 -= 65536
dig_P4 = b1[13] * 256 + b1[12]
if dig_P4 > 32767 :
    dig_P4 -= 65536
dig_P5 = b1[15] * 256 + b1[14]
if dig_P5 > 32767 :
    dig_P5 -= 65536
dig_P6 = b1[17] * 256 + b1[16]
if dig_P6 > 32767 :
    dig_P6 -= 65536
dig_P7 = b1[19] * 256 + b1[18]
if dig_P7 > 32767 :
    dig_P7 -= 65536
dig_P8 = b1[21] * 256 + b1[20]
if dig_P8 > 32767 :
    dig_P8 -= 65536
dig_P9 = b1[23] * 256 + b1[22]
if dig_P9 > 32767 :
    dig_P9 -= 65536

# BMP280 endereço, 0x76(118)
# Selecione o registro de medição de controle, 0xF4(244)
#		0x27(39)	Taxa de sobreamostragem de pressão e temperatura = 1
#					Modo Normal
bus.write_byte_data(0x76, 0xF4, 0x27)
# BMP280 endereço, 0x76(118)
# Selecione o registro de configuração, 0xF5(245)
#		0xA0(00)	Tempo de espera = 1000 ms
bus.write_byte_data(0x76, 0xF5, 0xA0)

time.sleep(0.5)

# BMP280 endereço, 0x76(118)
# Leia os dados de volta de 0xF7(247), 8 bytes
# Pressão MSB, Pressão LSB, Pressão xLSB, Temperatura MSB, temperature LSB
data = bus.read_i2c_block_data(0x76, 0xF7, 8)

# Convert3 os dados de pressão e temperatura para 19-bits
adc_p = ((data[0] * 65536) + (data[1] * 256) + (data[2] & 0xF0)) / 16
adc_t = ((data[3] * 65536) + (data[4] * 256) + (data[5] & 0xF0)) / 16

# Cálculos de compensação de temperatura
var1 = ((adc_t) / 16384.0 - (dig_T1) / 1024.0) * (dig_T2)
var2 = (((adc_t) / 131072.0 - (dig_T1) / 8192.0) * ((adc_t)/131072.0 - (dig_T1)/8192.0)) * (dig_T3)
t_fine = (var1 + var2)
cTemp = (var1 + var2) / 5120.0
fTemp = cTemp * 1.8 + 32

# Cálculos de compensação de pressão
var1 = (t_fine / 2.0) - 64000.0
var2 = var1 * var1 * (dig_P6) / 32768.0
var2 = var2 + var1 * (dig_P5) * 2.0
var2 = (var2 / 4.0) + ((dig_P4) * 65536.0)
var1 = ((dig_P3) * var1 * var1 / 524288.0 + ( dig_P2) * var1) / 524288.0
var1 = (1.0 + var1 / 32768.0) * (dig_P1)
p = 1048576.0 - adc_p
p = (p - (var2 / 4096.0)) * 6250.0 / var1
var1 = (dig_P9) * p * p / 2147483648.0
var2 = p * (dig_P8) / 32768.0
pressure = (p + (var1 + var2 + (dig_P7)) / 16.0) / 100

# Dados de saída 
print "Temperature in Celsius : %.2f C" %cTemp
print "Temperature in Fahrenheit : %.2f F" %fTemp
print "Pressure : %.2f hPa " %pressure