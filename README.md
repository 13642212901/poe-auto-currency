# AC

## 核心功能
## Core functions
* 通过配置文件不限制分辨率
* Auto use currency to match affix
* 辅助获取坐标功能
* Get your mouse coordinate
* 必须在游戏中使用
* Must use in the poe process
* 使用后会在当前目录增加log.txt日志，列出每次洗通货获得的词缀和是否匹配成功（成功：success 失败：error）
* There will be a log.Each cycle, record the item affix and match result

### 分辨率使用说明
### R.P. Explain
* 默认只配置了2560x1440，1920*1080
* Only 2560*1440 & 1920*1080 is available by default
* 非以上分辨率使用辅助的获取坐标功能编辑配置文件
* Ohter R.P. use alt+c to setting



### 配置文件格式说明
### Config file Explain
* 目前支持改造|机会|远古|点金|混沌|选择性重铸（如果确定使用重铸，会在每次使用通货后穿插一次重铸）
* Current support alteration|chance|ancient|alchemy|chaos|scouring(use after currency)
* 支持一个通货多个坐标配置，也就是说可以放在任何位置（不会识别通货的类型是否正确，请自行确认通货的类型），如背包，用来点猎首
* Support multi coordinate, can use on pack
* 基于屏幕分辨率 不是游戏分辨率 最好是一致
* The R.P. is screen R.P
* 分辨率宽度<1980  config_mini.ini
* R.P width < 1900 use config file is config_mini.ini
* 分辨率宽度>=1920 & < 2560的使用 config_1080.ini
* R.P width >= 1920 & < 2560 use config file is config_1080.ini
* v3.1.1之后分辨率宽度<1920  config_mini.ini
* R.P width < 1920 use config file is config_mini.ini
* 分辨率宽度>=2560 & < 3840的使用 config_2k.ini
* R.P width >= 2560 & < 3840 use config file is config_2k.ini
* 分辨率宽度>=3840 使用 config_1080.ini
* R.P width >= 3840 use config file is config_4k.ini
* 编辑配置文件可能会出现bom头，如果不懂如何去掉的话 把你配置好的坐标和对应的分辨率x*x发出来我帮你们上传
* 格式中的逗号 使用 英文输入法的“, ”不要用“，”
* 格式如下
```
[通货英文]
横坐标1,纵坐标1
横坐标2,纵坐标2
横坐标n,纵坐标n
[currency name]
x1,y1
x2,y2
x3,y3
```

### 辅助获取坐标功能说明
### Get coordinate
* 热键：alt+c
* Key: alt+c
* 会弹出坐标并复制到粘贴板，直接粘贴到配置文件的对应通货下即可


### 完成配置后使用说明
### Use explain after configuration
* 解压并打开exe
* Open main.ahk
* 打开通货仓/背包
* Open the currency warehouse or pack
* 鼠标放在要洗的装备的位置
* Move on the object item
* 按对应通货 <热键> 开始
* Send keyboard shortcuts
* 弹窗确定是否使用重铸石
* Determine whether to use scouring
* 弹窗添加你想要词缀的模糊匹配字符
* Fill your match string
* 模糊匹配的字符，请对着装备crtl+c 看看是中文还是英文
* Match with the results of the crtl+c
* 继续添加词缀（此功能为当前分组所有词缀作 “并且”） 即要求多条词缀 ps:单词缀这里就可以跳过了
* Fill your match string or continue
* 添加组，输入你想要的词缀。 分组功能为各个组之间作 “或”，不需要跳过即可。
* Append a group or continue
* 确定词缀是否正确
* Confirm the match string
* 等着结束
* wait to finish or use the crtl+c to finish
* 按 alt+s 结束

### 词缀说明
### Match string explain

* 格式：模糊匹配的《词缀字符》,词缀数值期望最小值,词缀数值期望最大值
* format: match string,min, max
* 将扫描物品词缀每一行，如包含《词缀字符》则匹配成功
* The app will match the string every line
* 如果有《期望最小值》《期望最大值》，将在匹配的行验证该行词缀中的“所有数值” 是否满足 《期望最小值》<"所有数值"< 《期望最大值》,有"其中一个"满足则匹配成功
* Judge the every numerical in the match line, if your have min or min&max
* 同一个分组是并且关系，不同分组是或者关系
* Same group is &, diff group is || or



### 热键说明
### Keyboard shortcuts
* alt+a 改造石 alteration
* alt+d 机会 chance
* alt+f 远古 ancient
* alt+g 点金 alchemy
* alt+h 混沌 chaos
### 其他：
### Ohter
* alt+s 手动结束 Stop
* crtl+s 重复上次 Restart with prew action
* alt+c 获取坐标 Get a coordinate

### Q&A
Q:配置错误
A:所有通货都要配置，分辨率应该是屏幕分辨率

Q:为什么会提示没有目标装备
A:获取装备属性crtl+c自己试下有没有用，这个操作有延时，我目前给了 200毫秒容错 200毫秒后没出粘贴板 就当成没物品了。

Q:如何确定自己的词缀关键字？
A:国服可以市集页找到后crtl+c 拿到记事本里看，国际服网页市集有复制功能
