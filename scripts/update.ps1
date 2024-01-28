rm -r build
rm -r dist
rm notify.spec
rm ..\..\..\utils\notify.exe

python -m PyInstaller notify.py
cp -r .\dist\notify\* ..\..\..\utils\

rm -r build
rm -r dist
rm notify.spec
