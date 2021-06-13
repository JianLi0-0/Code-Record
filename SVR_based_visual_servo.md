## SimpleITK医疗图像数据格式转换
```
import SimpleITK as sitk

file = "01a_us_tal.mnc"
written = "im_t4" + ".mhd"

reader = sitk.ImageFileReader()
reader.SetImageIO("MINCImageIO")
inputImageFileName = file
reader.SetFileName(inputImageFileName)
image = reader.Execute();

writer = sitk.ImageFileWriter()
outputImageFileName = written
writer.SetFileName(outputImageFileName)
writer.Execute(image)

# GDCMImageIO
# JPEGImageIO ( *.jpg, *.JPG, *.jpeg, *.JPEG )
# MINCImageIO ( *.mnc, *.MNC )
# MetaImageIO ( *.mha, *.mhd )
# NiftiImageIO ( *.nia, *.nii, *.nii.gz, *.hdr, *.img, *.img.gz )
# PNGImageIO ( *.png, *.PNG )
```

## Ubuntu安装ITK

下载源码

https://itk.org/download/



