require 'sdk'
ids= 0 ;
m.悬浮窗(2)
网易云={};
网易云.jss=0 ;


网易云.sdk=function()
    return self ;
end

网易云.runApp=function ()
    m.清理数据("com.netease.android.cloudgame")
    home();sleep(1000)--com.netease.android.cloudgame
    m.findone(R():text("网易云游戏"):getParent(),"网易云游戏")
    m.findone(R():text("同意"),"同意")
    m.findone(R():desc("我的"),"我的")
    m.findone(R():desc("未登录"):getParent(),"未登录")
end
网易云.登录=function()
::cql::
    网易云.runApp()
    while true do
        if find(R():desc("请输入你的手机号码")) then
            print('当前在输入手机号码页面')
            break ;
        end
        sleep(500);
    end
::hq::
    jmm.token_()
    sleep(100)
    -- jmy.ye()
    ids=jmm.取手机号()
	if ids==0 then 
	   print("取号过于频繁服务器拒绝访问")
	   sleep(2000)
	   goto hq ; 
	end
    print("手机号："..ids)
    input(R():type("EditText"),ids)
    sleep(1000)
    m.findone(R():desc("下一步"),"下一步",2000,2600)
    if find(R():desc("请输入正确的手机号码")) then
        jmm.拉黑();
        goto hq ;
    end
    local yz=jmm.验证码();
    if yz==false then
        if findColor({4,173,315,451,"52,237,#61686F|59,237,#28333D|60,248,#61686F|239,277,#FCFCFD|218,276,#FEFEFE",95}) then
            m.findColor({4,173,315,451,"52,237,#61686F|59,237,#28333D|60,248,#61686F|239,277,#FCFCFD|218,276,#FEFEFE",95},"返回")
        end
        if findColor({12,198,125,271,"55,238,#B0B4B7|50,238,#CDD0D2|58,238,#28333D|63,226,#F3F4F4",95}) then
            m.findColor({12,198,125,271,"55,238,#B0B4B7|50,238,#CDD0D2|58,238,#28333D|63,226,#F3F4F4",95},"返回")
        end
        goto hq ;
    end
    input(R():type("EditText"),yz);sleep(1000)
    if findColor({34,620,100,703,"71,660,#03C47E|71,664,#244145|71,667,#138462|82,661,#03C47E",95}) then
      else
        click(71,660);sleep(500)
    end
    m.findone(R():desc("登录"),"登录")
    if find(R():desc("验证码错误")) then
        print("验证码错误")
        if findColor({4,173,315,451,"52,237,#61686F|59,237,#28333D|60,248,#61686F|239,277,#FCFCFD|218,276,#FEFEFE",95}) then
            m.findColor({4,173,315,451,"52,237,#61686F|59,237,#28333D|60,248,#61686F|239,277,#FCFCFD|218,276,#FEFEFE",95},"返回")
        end
        if findColor({12,198,125,271,"55,238,#B0B4B7|50,238,#CDD0D2|58,238,#28333D|63,226,#F3F4F4",95}) then
            m.findColor({12,198,125,271,"55,238,#B0B4B7|50,238,#CDD0D2|58,238,#28333D|63,226,#F3F4F4",95},"返回")
        end
        goto hq ;
    end
    m.findone(R():desc("游戏"):type("View"),"游戏",2000,2100)
    if findColor({21,728,654,903,"519,809,#03C47E|505,826,#FFFFFF|234,813,#28333D|292,854,#61686F|399,820,#03C47E",95}) then
        m.findColor({21,728,654,903,"519,809,#03C47E|505,826,#FFFFFF|234,813,#28333D|292,854,#61686F|399,820,#03C47E",95},"马上去玩游戏")
    end
    if findColor({223,1009,522,1166,"359,1079,#CCCED1|359,1081,#FFFFFF|360,1073,#1E2831|359,1051,#B4C0C9|387,1081,#1F2931",95}) then
        m.findColor({223,1009,522,1166,"359,1079,#CCCED1|359,1081,#FFFFFF|360,1073,#1E2831|359,1051,#B4C0C9|387,1081,#1F2931",95},"弹窗")
    end
    m.悬浮窗(3)
    m.findColors({10,70,128,158,"61,113,#03C47E|51,103,#03C47E|65,126,#03C47E",95},"放大镜",390,1)
    m.悬浮窗(2)
    input(R():type("EditText"),"光遇")
    sleep(1000)
    -- m.findone(R():desc("秒玩"):target(1),"秒玩")
    m.findColor({380,259,712,531,"618,405,#03C47E|609,405,#E5F9F2|598,410,#FFFFFF|645,415,#03C47E|629,412,#FFFFFF",95},"秒玩",2000,2600)
    -- m.findone(R():desc("进入游戏"),"进入游戏")
    if findColor({34,489,676,906,"403,766,#03C47E|231,752,#313C46|231,751,#8B969F|485,757,#FFFFFF|630,784,#03C47E",95}) then
        print("进入游戏失败")
        goto cql ;
    end
	if find(R():text("请输入姓名"):type("EditText")) then 
        input(R():text("请输入姓名"):type("EditText"),"赵博鹏");sleep(500)
        input(R():text("请输入身份证号"):type("EditText"),"230104199405193715");sleep(500)
		m.findone(R():desc("提交认证"),"提交认证")
	end
    m.findColor({246,892,474,1040,"353,959,#03C47E|353,972,#FFFFFF|283,966,#03C47E|425,975,#C0F0DF",95},"进入游戏")
    m.findone(R():text("知道了"),"知道了")
    m.findone(R():text("我知道了"),"我知道了")
    m.findone(R():type("Button"),"弹窗")
    if find(R():type("Button")) then m.findone(R():type("Button"),"弹窗") end
end
ssp=0 ; 
光遇sky={}
光遇sky.协议=function()
    m.findColor({791,534,1068,661,"927,605,#24B35E|916,602,#F4FFFC|913,597,#C8FBDB|946,613,#E8FBF5",95},"接受")
    while true do
        if findColor({481,162,764,268,"562,220,#FFCFD2|561,214,#F59DA5|625,212,#535655",95}) then
            print('进入登录页面')
            break
        end
        sleep(3000)
        if findColor({698,205,1015,487,"858,347,#F8F3D5|864,347,#FBF2D5|858,340,#F8F3D5",95}) then
            print("当前已有登录成功账号")
            m.findColor({253,41,427,173,"337,103,#BBBCC1|319,108,#03040D|315,121,#2A2C2E|350,90,#FDFFFD",95},"个人中心")
            m.findColor({1048,78,1208,238,"1144,166,#E57370|1142,166,#FFF3ED|1134,156,#CF6068",95},"切换账号")
            m.findColor({539,481,728,566,"635,523,#EF7E86|638,519,#F5FEF6|644,516,#E08083|696,531,#FBA09F",95},"其他账号登录")
            break ;
        end
		if findColor({657,167,1089,613,"894,436,#148A7D|884,439,#F0FFFF|896,408,#FDFFFD",95}) then
            print('设备数据异常');
			ssp=1 ; 
			break ; 
		end
    end
end

光遇sky.登录=function()
    if ssp==1 then 
        return 0 ; 
    end	
    if findColor({539,481,728,566,"635,523,#EF7E86|638,519,#F5FEF6|644,516,#E08083|696,531,#FBA09F",95}) then
        m.findColor({539,481,728,566,"635,523,#EF7E86|638,519,#F5FEF6|644,516,#E08083|696,531,#FBA09F",95},"其他账号登录")
    end
    m.findColor({439,508,852,574,"507,543,#A3A6A7|463,543,#F7FAFC|474,542,#D7D9DB|628,542,#505254",95},"同意协议")
    m.findColor({672,454,835,522,"754,484,#FF615A|706,482,#7B4C45|698,476,#D81D13|785,489,#FFE7DB",95},"网易邮箱")
    if findColor({552,390,727,484,"639,433,#F34E51|633,430,#FFEAE9|664,433,#FFEBEC",95}) then
        print("当前在登录页面")
    end
::yc::
    click(626,255);sleep(900)
::jx::
    m.sign=m.sign_();
    local 账号,密码=m.获取小号数据()
    if 账号 ~= "noHave" then
        print(账号)
        print(密码)
        if findColor({1049,613,1258,715,"1164,664,#FF6527|1211,660,#FFFFF8|1139,690,#FF662A",95}) then
            if findColor({968,185,1145,252,"1082,220,#FAFDF9|1082,215,#D8DBD8|1075,220,#D9DCD9|1093,220,#FDFFFD|1092,220,#E8EBE8",95}) then
                m.findColor({968,185,1145,252,"1082,220,#FAFDF9|1082,215,#D8DBD8|1075,220,#D9DCD9|1093,220,#FDFFFD|1092,220,#E8EBE8",95},"清除历史")
            end
            if findColor({199,112,397,210,"243,143,#8D908F|261,140,#4A4C4E|240,144,#F7FAF9",95})then
                inputname(账号)
            end
        end
        if findColor({876,189,1050,248,"992,220,#FDFFFD|991,216,#D8DBD8|991,223,#E0E3E0|989,220,#D9DCD9",95}) then
            m.findColor({876,189,1050,248,"992,220,#FDFFFD|991,216,#D8DBD8|991,223,#E0E3E0|989,220,#D9DCD9",95},"清除历史")
        end
        if findColor({763,14,1000,149,"909,72,#828486|903,78,#D3D6D7|879,65,#F9FBFD",95}) then
            inputpwd(密码)
        end
        --下一步
        m.findColor({1036,599,1278,718,"1173,664,#FF6527|1166,671,#FFF6E3|1132,675,#FF662B",95},"下一步",2000,2600);
        --增加判断是否登录成功
        while true do
            if findColor({460,354,799,516,"639,432,#F74B4E|619,441,#FFEAE6|655,442,#FFFFFF|671,458,#FA504E",95}) then
                m.更新小号数据("账号异常","1")
                print("账号异常")
                goto yc ;
            end
            if findColor({698,205,1015,487,"858,347,#F8F3D5|864,347,#FBF2D5|858,340,#F8F3D5",95}) then
                print("登录成功")
                m.更新小号数据(ids,"6")
                break ;
            end
            sleep(1000)
            if findColor({657,167,1089,613,"894,436,#148A7D|884,439,#F0FFFF|896,408,#FDFFFD",95}) then
                print('设备数据异常');
                m.findColor({657,167,1089,613,"894,436,#148A7D|884,439,#F0FFFF|896,408,#FDFFFD",95},"确定")
                m.更新小号数据("设备数据异常","1")
                return 0 ;
            end
        end
      else
        uii={
            title="警告";
            views={
                {type="text",value="没有更多的小号了，请及时补充"},

            }
        }
        local ret = show( uii )
        if ret then
            print('用户选择了确认')
            goto jx
          else
            print('选择了退出')
            exit() ;
        end
    end
end
光遇sky.登录1=function()
    while true do
	    if ssp==1 then 
	        ssp=0 ; 
            print("已达设备最大数")
            return true 
        end	
        m.悬浮窗(3)
        m.findColor({253,41,427,173,"337,103,#BBBCC1|319,108,#03040D|315,121,#2A2C2E|350,90,#FDFFFD",95},"个人中心")
        m.findColor({1048,78,1208,238,"1144,166,#E57370|1142,166,#FFF3ED|1134,156,#CF6068",95},"切换账号")
        m.findColor({539,481,728,566,"635,523,#EF7E86|638,519,#F5FEF6|644,516,#E08083|696,531,#FBA09F",95},"其他账号登录")
        m.悬浮窗(2)
        if 光遇sky.登录()==0 then
            print("已达设备最大数")
			ssp=0 ; 
            return true ;
        end
    end

end

ui={
    title="网易云游戏";
    -- time = 10; -- 10秒后自动选择确认
    views={
        {title ="小号账号",type="edit",hint="请输入账号",value="yinerqwe",id="name"},
        {title ="小号密码",type="edit",hint="请输入密码",value="123456",id="pwd"},
        {title ="小号号池",type="edit",value="1",id="hcid"},
        {title ="珊瑚账号",type="edit",hint="请输入账号",value="badian",id="jname"},
        {title ="珊瑚密码",type="edit",hint="请输入密码",value="qwe123",id="jpwd"},
        {title ="项 目 I  D",type="edit",value="31921", id="xmid"},
    }
}
local ret = show( ui )
if ret then
    print('启动成功')
  else
    print('用户选择了取消')
    exit();
end

jm.name="newhacke"
jm.pwd="aa123123"
m.name= name ;
m.pwd=pwd ;
m.hcid=hcid ;
jmy.name=jname ;
jmy.pwd=jpwd;
jmm.id=xmid;--"31201----MQ4Z96" ;
jm.id="04895"
jmm.name=jname; 
jmm.pwd=jpwd; 

 



while true do
    网易云.登录()
    光遇sky.协议()
    光遇sky:登录()
    光遇sky.登录1()
end

