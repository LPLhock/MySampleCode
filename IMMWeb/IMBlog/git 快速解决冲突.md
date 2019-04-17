# git 快速解决冲突

合并两个改变较大版本,导致严重冲突, 文件夹直接都打不开了。


YZHYolo.xcodeproj:The project ‘YZHYolo’ is damaged and cannot be opened due to a parse error. Examine the project file for invalid edits or unresolved source control conflicts.


YZHYolo Workspce Group: The file couldn’t be opened.
```
<<<<<<< HEAD
				PRODUCT_BUNDLE_IDENTIFIER = com.yzhchain.yolo;
=======
				PRODUCT_BUNDLE_IDENTIFIER = com.yzhchain.YOLOIM;
>>>>>>> developer
				PRODUCT_NAME = "$(TARGET_NAME)";
				PROVISIONING_PROFILE_SPECIFIER = "";
				SHARED_PRECOMPS_DIR = "$(OBJROOT)/SharedPrecompiledHeaders";
				TARGETED_DEVICE_FAMILY = 1;
				USER_HEADER_SEARCH_PATHS = "$(PODS_ROOT)/**";
			};
			name = Release;
		};
```
		
## 原因
主要是由于同时修改到了 project.pbxproj 文件内容

## 参考

[解决iOS项目文件合并.xcodeproj冲突](https://bingozb.github.io/11.html)
	


