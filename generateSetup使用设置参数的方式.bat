@echo off
copy ..\bin\P_LhTransProject.dll p_reg /Y
iscc /Qp  "/DOUTPUTDIR=��������" "/DPRINTTYPE=0" "/DMerchantId=888051053110001"  "/DPrint=COM3" "/DDSHH=000301" "/DGunPort=USB"  setup.iss
iscc /Qp  "/DOUTPUTDIR=��һ��" "/DPRINTTYPE=0" "/DMerchantId=888051053110001"  "/DPrint=COM3" "/DDSHH=90443" "/DGunPort=USB"  setup.iss
iscc /Qp  "/DOUTPUTDIR=���ֶ���" "/DPRINTTYPE=0" "/DMerchantId=888051053110001"  "/DPrint=COM5" "/DDSHH=90260" "/DGunPort=USB"  setup.iss
iscc /Qp  "/DOUTPUTDIR=����" "/DPRINTTYPE=0" "/DMerchantId=888051053110001"  "/DPrint=COM2" "/DDSHH=69504" "/DGunPort=USB"  setup.iss
iscc /Qp  "/DOUTPUTDIR=����ٻ�" "/DPRINTTYPE=0" "/DMerchantId=115311100090002"  "/DPrint=COM2" "/DDSHH=90002" "/DGunPort=USB"  setup.iss
iscc /Qp  "/DOUTPUTDIR=һ���ɽ�" "/DPRINTTYPE=0" "/DMerchantId=115311100090271"  "/DPrint=COM1" "/DDSHH=90271" "/DGunPort=USB"  setup.iss
echo "��ȫ������"