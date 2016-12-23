@echo off
copy ..\bin\P_LhTransProject.dll p_reg /Y
iscc /Qp setup2.iss



echo "已全部生成"