@echo off
copy ..\bin\P_LhTransProject.dll p_reg /Y
iscc /Qp  "/DOUTPUTDIR=无锡奥莱" "/DPRINTTYPE=0" "/DMerchantId=888051053110001"  "/DPrint=COM3" "/DDSHH=000301" "/DGunPort=USB"  setup.iss
iscc /Qp  "/DOUTPUTDIR=又一城" "/DPRINTTYPE=0" "/DMerchantId=888051053110001"  "/DPrint=COM3" "/DDSHH=90443" "/DGunPort=USB"  setup.iss
iscc /Qp  "/DOUTPUTDIR=杨浦东方" "/DPRINTTYPE=0" "/DMerchantId=888051053110001"  "/DPrint=COM5" "/DDSHH=90260" "/DGunPort=USB"  setup.iss
iscc /Qp  "/DOUTPUTDIR=滨江" "/DPRINTTYPE=0" "/DMerchantId=888051053110001"  "/DPrint=COM2" "/DDSHH=69504" "/DGunPort=USB"  setup.iss
iscc /Qp  "/DOUTPUTDIR=友谊百货" "/DPRINTTYPE=0" "/DMerchantId=115311100090002"  "/DPrint=COM2" "/DDSHH=90002" "/DGunPort=USB"  setup.iss
iscc /Qp  "/DOUTPUTDIR=一百松江" "/DPRINTTYPE=0" "/DMerchantId=115311100090271"  "/DPrint=COM1" "/DDSHH=90271" "/DGunPort=USB"  setup.iss
echo "已全部生成"