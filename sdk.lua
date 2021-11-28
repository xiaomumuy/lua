function split( str,reps )
    local resultStrList = {}
    string.gsub(str,'[^'..reps..']+',function ( w )
        table.insert(resultStrList,w)
    end)
    return resultStrList
end
m={};
m.name="";
m.pwd="";
m.sign="";
m.id="";
m.Cookie="";
m.hcid="1";
m.key="";
m.num="";
m.sign_=function()
    local p={
        url="http://sky.57753322.com/api/getnext/getsign/name/"..m.name.."/pwd/"..m.pwd.."/kfkey/af6d3c0052ee392f897413772b699b3a/shebei/"..getPhoneId() ;
        timeout=30 ;
    }
    local res=httpGet(p)
    if res then
        local cks=res.header['set-cookie'][1];
        local cook=split(cks,";");
        local shd=res.header['set-cookie'][2];
        local shis=split(shd,";");
        m.Cookie=cook[1]..';'..shis[1];
        local obj=JsonDecode(res.body)
        if obj.msg=="获取成功" then
            return obj.data ;
        end
    end
    return false ;
end
m.获取小号数据=function()
    local p={
        header={
            Cookie=m.Cookie;
        };
        url="http://sky.57753322.com/api/getnext/next/sign/"..m.sign.."/hcid/"..m.hcid;
        timeout=30;
    }
    local res=httpGet(p)
    if res then
        local obj=JsonDecode(res.body)
        if obj.msg=="获取成功" then
            m.id=obj.data.id ;
            local a=obj.data.email;local b=obj.data.pwd ;
            return a,b
          else
            local a=obj.code;local b=obj.msg ;
            return a,b
        end
    end
end
m.更新小号数据=function(备注,状态)
    状态=状态 or "0" ;
    p={
        header={
            Cookie=m.Cookie
        };
        url="http://sky.57753322.com/api/getnext/notice/sign/"..m.sign.."/id/"..m.id.."/note/"..备注.."/candlenum/nil/status/"..状态;
        timeout=30
    };
    local res=httpGet(p)
    if res then
        local obj=JsonDecode(res.body)
        if obj.msg=="更新成功" then
            return true ;
        end
    end
    return false
end
m.提交二维码=function(链接)
    p={
        header={
            Cookie=m.Cookie
        };
        url="http://sky.57753322.com/api/getnext/sxst/";
        param={
            id=tostring(m.id),
            status="1",
            ewm=链接
        };
        timeout=60
    };
    local res=httpPost(p)
    if res then
        local obj=JsonDecode(res.body)
        if obj.msg == "更新成功" then
            return true ;
        end
    end
end
m.获取链接=function()
    p={
        header={
            Cookie=m.Cookie
        };
        url="http://sky.57753322.com/api/getnext/get_sx/sign/"..m.sign.."/hcid/"..m.hcid;
        timeout=30
    };
    local res=httpGet(p)
    if res then
        local obj=JsonDecode(res.body)
        if obj.msg=="获取小号成功" then
            m.id=obj.data.id ;
            return obj.data.ewm ;
        end
    end
    return false
end
m.更新送心状态=function(zt)
    local p = {
        url = "http://sky.57753322.com/api/getnext/put_status/status/"..zt.."/id/"..m.id ;
        timeout=30 ;
    }
    local res=httpGet(p)
    if res then
        local obj=JsonDecode(res.body);
        if obj.msg=="更新送心状态成功" then
            return true ;
        end
    end
    return false ;
end
m.获取送心状态=function()
    local p = {
        url = "http://sky.57753322.com/api/getnext/get_status/id/"..m.id ;
        timeout=30 ;
    }
    local res=httpGet(p)
    if res then
        local obj=JsonDecode(res.body);
        if obj.msg=="账号送心成功" then
            return obj.data ;
        end
    end
    return false ;
end
--更新收心数
m.收心计数=function()
    local p={
        url="http://jd.57753322.com/api/api/upsoket?key="..m.key.."&num="..m.num ;
        timeout=30 ;
    }
    local res=httpGet(p)
    if res then
        local obj=JsonDecode(res.body);
        if obj.msg=="更新成功" then
            return true ;
        end
    end
    return false ;
end
m.获取计数=function ()
    local p={
        url="http://jd.57753322.com/api/api/getnum?key="..m.key ;
        timeout = 30 ;
    }
    local res=httpGet(p)
    if res then
        local obj =JsonDecode(res.body)
        if obj.code=="ok" then
            return obj.data.nownum
        end
    end
    return nil ;
end
--坐标点击
m.click=function(x,y)
    return click(x+math.random(-10,10),y+math.random(-10,10),math.random(20,90))
end
--寻找控件点击
m.findone=function(node,msg,min,max)
    min = min or 1000 ; max=max or 1200 ;
    -- print(min..","..max)
    sleep(500);
    for i=1,30 do--寻找10次，找不到怎退出
        local p=find(node)
        if p then
            p:click()
            print("点击"..msg.."成功")
            sleep(math.random(min,max))
            return true ;
        end
        sleep(1000)
    end
    return false ;
end
--寻找控件点击坐标中心
m.findbounds=function(node,msg,x,y,min,max)
    sleep(500)
    min=min or 1000 ; max=max or 1200 ;
    for i=1,30 do
        local p=find(node)
        if p then
            local x1=math.floor((p.rect.left+p.rect.right)/2)
            local y1=math.floor((p.rect.top+p.rect.bottom)/2)
            m.click(x1+x,y1+y)
            print("点击"..msg.."成功")
            sleep(math.random(min,max))
            return true ;
        end
        sleep(1000)
    end
    return false ;
end
--找色点击
m.findColor=function(color,msg,min,max)
    sleep(500)
    min=min or 1000 ; max=max or 1200 ;
    for i=1 , 30 do
        local p = findColor(color)
        if p then
            m.click(p.x,p.y)
            print("点击"..msg.."成功")
            sleep(math.random(min,max))
            return true ;
        end
        sleep(500)
    end
    return false ;
end
m.findColors=function(color,msg,xx,yy,min,max)
    sleep(500)
    min=min or 1000 ; max=max or 1200 ;
    for i=1 , 30 do
        local p = findColor(color)
        if p then
            m.click(p.x+xx,p.y+yy)
            print("点击"..msg.."成功")
            sleep(math.random(min,max))
            return true ;
        end
        sleep(500)
    end
    return false ;
end
--清除数据
m.清理数据=function(pkg)
    pkg=pkg or "com.netease.sky"
    print("清除光遇数据")
    exec("pm clear "..pkg)--清除光遇数据
    sleep(1000);
end
m.runApp=function(pkg)
    while true do
        if find(R():name(pkg)) then
            print("已启动")
            sleep(2000)
            return true ;
          else
            runApp(pkg);
            sleep(2000)
        end
    end
end
m.打开邀请链接=function(链接)
    exec(" am start -a android.intent.action.VIEW -d "..链接)
    sleep(3000)
    if find(R():text("Chrome")) then
        m.findone(R():text("Chrome"):getParent(),"Chrome")
        if find(R():text("始终")) then
            m.findone(R():text("始终"),"始终")
        end
    end
    if find(R():text("接受并继续")) then
        m.findone(R():text("接受并继续"),"接受变继续")
    end
end
--悬浮窗设置
m.悬浮窗=function(number)
    s=getScreen()
    config ={
        x =1; -- 位置x
        y = 1; --位置y
        width= 300; --宽度
        height=160; --高度
        color = "#00DCBC";--ARGB 字体颜色
        bgcolor ="#90000000"; --背景颜色(ARGB);传统RGB 颜色前加两位可代表透明度 00-FF【16进制】 ，00代表完全透明
        mode = number; --模式 :1= 显示可点击,2=显示不可点击，3=隐藏
        size = 15;-- 字体大小
        debug = false; --是否输出系统日志 false =不输出，true = 输出
        shadow = true; --是否显示阴影，false：不显示 true 显示；
    };
    logConfig(config);
end
function 选择启动(pkg,msg)
    if find(R():text(pkg):getParent()) then
        m.findbounds(R():text(pkg):getParent(),msg,1,1,600,900)
    end
    if find(R():text(pkg):getParent()) then
        m.findbounds(R():text(pkg):getParent(),msg,1,1,600,900)
      else
        if find(R():text("仅此一次")) then
            m.findbounds(R():text("仅此一次"),"仅此一次",1,1,1600,2000)
        end
    end
end
function 启动(str)
    if str=="官方渠道" then
        选择启动("com.netease.sky","官方渠道")
      elseif str=="华为渠道" then
        选择启动("com.netease.sky.huawei","华为渠道")
      elseif str=="应用宝渠道" then
        选择启动("com.tencent.tmgp.eyou.eygy","应用宝渠道")
      elseif str=="九游渠道" then
        选择启动("com.netease.sky.aligames","九游渠道")
      elseif str=="OPPO渠道" then
        选择启动("com.netease.sky.nearme.gamecenter","OPPO渠道")
      elseif str=="小米渠道" then
        选择启动("com.netease.sky.mi","小米渠道")
      elseif str=="vivo渠道" then
        选择启动("com.netease.sky.vivo","vivo渠道")
    end
end
function 接受邀请()
    while true do
        local p=finds(R():text("按钮"))
        if p then
            for k,v in pairs(p) do
                if k==2 then
                    v:click()
                    print("点击接受邀请成功")
                    sleep(2000)
                    if find(R():text("按钮")) then
                        v:click()
                        print("点击接受邀请成功")
                        sleep(2000)
                    end
                end
            end
            if find(R():text("按钮")) then
              else
                break ;
            end
        end
    end
end
function mber(str,qzf,zend)
    local description = str ;
    local targetNum1 = description:gsub("%D+", "")
    local targetKey = "("..qzf.."%d+"..zend..")"
    local _, _, gotKey = string.find(description, targetKey)
    local targetNum2 = gotKey:gsub("%D+", "")
    return targetNum2 ;
end
jm={};
jm.name="";
jm.pwd="";
jm.token="";
jm.id="";
jm.jm=function(msg)
    local p={
        url="https://ldsxkl.lyhlcn.com/sky/jm.php?jiemi=jm&msg="..msg ;
    };
    local res=httpGet(p)
    if res then
        if res.body ~="失败" then
            return res.body ;
        end
    end
end
jm.token_=function()
    local p={
        url="http://154.23.128.2:82/api/yonghu_login";
        param={
            type="1",
            username=jm.name,
            password=jm.pwd,
        };
    };
    local res = httpPost(p);
    if res then
        local obj=jm.jm(res.body)
        obj=split(obj,"|")
        if obj[1]=="成功" then
            jm.token=obj[2]
            -- print(jm.token)
        end
    end
end
jm.ye=function()
    local p={
        url="http://154.23.128.2:889/api/xhqyhzb";
        param={
            lx="3",
            token=jm.token,
        };
    };
    local res = httpPost(p);
    if res then
        local obj=jm.jm(res.body)
        obj=split(obj,"|")
        if obj[1]=="成功" then
            print("余额："..obj[2].." 元")
        end
    end
end
jm.取手机号=function()
    jm.ye()
    local p={
        url="http://154.23.128.2:84/api/shouduanxin_zaixianhaoma_plpt";
        param={
            xmid=jm.id,--项目ID
            xzgj="中国",--国家
            xzyys="不限",--运营商
            xzsf="不限",--省份
            hmlx="实卡",--号码类型(支持:不限,虚拟,实卡)
            glhmd="1",--是否过滤拉黑的手机号
            qhsl="1",--取号数量 (提交数字)
            dcjs= "1",--号码使用次数
            kfz=jm.name,
            token=jm.token,
        };
    };
    local res = httpPost(p);
    if res then
        local obj=jm.jm(res.body)
        obj=split(obj,"|")
        if obj[1]=="成功" then
            jm.iPhone=obj[2] ;
            return obj[2] ;
        end
    end
end
jm.释放=function()
    jm.ye()
    local p={
        url="http://154.23.128.2:86/api/shouduanxin_shifang";
        param={
            xmid=jm.id,--项目ID
            sjhm=jm.iPhone,--任务中使用号码
            token=jm.token,
        };
    };
    local res = httpPost(p);
    if res then
        local obj=jm.jm(res.body)
        obj=split(obj,"|")
        if obj[1]=="成功" then
            print(jm.iPhone.."已释放")
            return obj[2] ;
        end
    end
end
jm.加黑=function()
    jm.ye()
    local p={
        url="http://154.23.128.2:86/api/shouduanxin_lahei";
        param={
            xmid=jm.id,--项目ID
            sjhm=jm.iPhone,--任务中使用号码
            token=jm.token,
        };
    };
    local res = httpPost(p);
    if res then
        local obj=jm.jm(res.body)
        obj=split(obj,"|")
        if obj[1]=="成功" then
            print(jm.iPhone.."已拉黑")
            return obj[2] ;
        end
    end
end
-- POST：【收短信拉黑手机号】
-- url:   http://154.23.128.2:86/api/shouduanxin_lahei
-- data:  xmid=项目ID&sjhm=手机号码&token=提交token
--  ----------------------------
--  1.参数：xmid=提交 项目ID (项目ID或者专属对接码,请先去PC端收藏获取)
--  ----------------------------
--  2.参数：sjhm=提交 任务中手机号 (13800138000)
--  ----------------------------
--  3.参数：token=提交 token (用户名密登录取回)
--  ----------------------------
--  [返回信息]：
--  情况1.成功|已拉黑此手机号 (手机号拉黑成功)
--  情况2.已拉黑此手机号但已来码 .成功|13800138000-短信内容xxxxxxxxxx (已拉黑成功,但已有验证码,金额会扣除)
jm.指定号码=function(iPhone)
    jm.ye()
    local p={
        url="http://154.23.128.2:84/api/shouduanxin_zaixianhaoma_zhidin";
        param={
            xmid=jm.id,--项目ID
            sjhm=iPhone,--指定号码
            dcjs= "1",--号码使用次数
            kfz=jm.name,
            token=jm.token,
        };
    };
    local res = httpPost(p);
    if res then
        local obj=jm.jm(res.body)
        obj=split(obj,"|")
        if obj[1]=="成功" then
            return obj[2] ;
        end
    end
end
jm.验证码=function()
    jm.ye()
    local p={
        url="http://154.23.128.2:85/api/shouduanxin_quma";
        param={
            xmid=jm.id,--项目ID
            sjhm=jm.iPhone,--任务中使用号码
            token=jm.token,
        };
    };
    jc=0 ;
:: cl ::
    local res = httpPost(p);
    if res then
        local obj=jm.jm(res.body)
        if obj=="查询无此任务" then
            print("说明任务已释放")
            return false ;
        end
        obj=split(obj,"|")
        if obj[1]=="成功" then
            if obj[3] =="等待来码" then
                jc=jc+1
                print("等待来码"..jc.."次")
                sleep(1000)
                if js>=60 then
                    print('获取验证码超时')--此时需要将号码拉黑处理
                    return false ;
                  else
                    goto cl ;
                end
              else
                return mber(obj[3],"：","，请")
            end
        end
    end
end

jmy={};
jmy.name="";
jmy.pwd="";
jmy.token ="";
jmy.iPhone="";
jmy.token_=function()
    local p = {
        url="http://121.204.249.224:8000/api/sign/username="..jmy.name.."&password="..jmy.pwd,
    } ;
    local res = httpGet(p)
    if res then
        local obj =split(res.body,"|") ;
        if obj[1]=="1" then
            jmy.token=obj[2] ;
            return obj[2]
        end
        return false
    end
end
jmy.ye=function()
    local p={
        url="http://121.204.249.224:8000/api/yh_gx/token="..jmy.token ;
    }
    local res = httpGet(p)
    if res then
        print(res.body)
        local obj =split(res.body,"|") ;
        if obj[2]=="0" or obj[2]=="1" then
            print("余额："..obj[1].."元")
            return obj[1]
        end
        return false
    end
end

jmy.取手机号=function(phone)
    phone=phone or "" ;
    local p ={
        url ="http://121.204.249.224:8000/api/yh_qh/id="..jmy.id.."&operator=0&Region=0&card=0&phone="..phone.."&loop=1&filer=162|&token="..jmy.token ;
    }
    --重新获取
::cl::
    local res = httpGet(p) ;
    if res then
        local obj=split(res.body,"|")
        if obj[1]=="1" then
            print('获取手机号成功')
            jmy.phone=obj[2];
            return obj[2] ;
          else
            print("没有可用号码")
            sleep(1000)
            goto cl ;
        end
    end
    return 0 ;
end
jmy.加黑=function()
    local p = {
        url="http://121.204.249.224:8000/api/yh_lh/id="..jmy.id.."&phone="..jmy.phone.."&token="..jmy.token ;
    }
    local res = httpGet(p) ;
    if res then
        -- print(res.body)
        local obj = split(res.body,"|")
        if obj[1]=="1" then
            -- print(obj[2])
            return true
        end
        return false ;
    end
end
jmy.释放=function()
    local p = {
        url="http://121.204.249.224:8000/api/yh_sf/id="..jmy.id.."&phone="..jmy.phone.."&token="..jmy.token ;
    }
    local res = httpGet(p) ;
    if res then
        local obj = split(res.body,"|")
        if obj[1]=="1" then
            print("释放成功")
            return true
        end
        return false ;
    end
end
jmy.验证码=function()
    local p = {
        url ="http://121.204.249.224:8000/api/yh_qm/id="..jmy.id.."&phone="..jmy.phone.."&t="..jmy.name.."&token="..jmy.token ;
    } ;
    local jc=0 ;
::cl1:: --重新获取
    local res=httpGet(p)
    if res then
        local obj =split(res.body,"|") ;
        if obj[1]=="1" then
            jmy.释放();
            return string.match(obj[2],"%d+") ;
          else
            -- print(obj[2]) ;
            jc=jc+1
            print("获取验证码"..jc.."次")
            sleep(1000)
            if jc >= 60 then
                print("获取验证码超时")
                jmy.加黑()
                return false ;
              else
                goto cl1 ;
            end
        end
    end
    return false
end

jmm={
    name="",
    pwd="",
    id="",
    token ="";
    Phone="";
};
jmm.token_=function()
    local p = {
        url="http://api.fghfdf.cn/api/logins?username="..jmm.name.."&password="..jmm.pwd,
    }
    local res=httpGet(p) ;
    if res then
        -- print(res.body)
        local obj =JsonDecode(res.body)
        jmm.token=obj.token ;
        local a=JsonEncode(obj.data[1])
        local b=JsonDecode(a)
        print("余额："..b.money)
        return obj.token ;
    end
    return false ;
end
jmm.取手机号=function()
    local p = {
        url="http://api.fghfdf.cn/api/get_mobile?token="..jmm.token.."&project_id="..jmm.id.."&loop=1&operator=0&phone_num=&scope=&address=&api_id="..jmm.name.."&scope_black=162,171" ;
    } ;
::cl::
    local res=httpGet(p)
    if res then
        -- print(res.body)
        local obj =JsonDecode(res.body)
        if obj.message=="ok" then
            print('获取手机号成功')
            jmm.phone=obj.mobile;
            return obj.mobile ;
          else
            print("没有可用号码")
            sleep(1000)
            goto cl ;
        end
    end
    return 0
end
jmm.释放=function()
    local p={
        url="http://api.fghfdf.cn/api/free_mobile?token="..jmm.token.."&phone_num="..jmm.phone ,
    }
    local res =httpGet(p)
    if res then
        local obj =JsonDecode(res.body)
        if obj.message=="ok" then
            print("释放成功")
            return true
        end
    end
end
jmm.拉黑=function()
    local p={
        url="http://api.fghfdf.cn/api/add_blacklist?token="..jmm.token.."&project_id="..jmm.id.."&phone_num="..jmm.phone ,
    }
    local res = httpGet(p);
    if res then
        local obj =JsonDecode(res.body)
        if obj.message=="ok" then
            print("拉黑成功")
            return true
        end
    end
end

jmm.验证码=function()
    local p={
        url="http://api.fghfdf.cn/api/get_message?token="..jmm.token.."&project_id="..jmm.id.."&phone_num="..jmm.phone,
    }
    local jc=0 ;
::cl1::
    local res=httpGet(p)
    if res then
        -- print(res.body)
        local obj =JsonDecode(res.body)
        if obj.message=="ok" then
            if obj.code ~= nil then
                print("获取验证码成功："..obj.code)
                jmm.释放();
                return obj.code ;
              else
                jc=jc+1
                print("获取验证码"..jc.."次")
                sleep(1000)
                if jc >= 60 then
                    print("获取验证码超时")
                    jmm.拉黑()
                    return false ;
                  else
                    goto cl1 ;
                end
            end
          else
            jc=jc+1
            print("获取验证码"..jc.."次")
            sleep(1000)
            if jc >= 60 then
                print("获取验证码超时")
                jmm.拉黑()
                return false ;
              else
                goto cl1 ;
            end
        end
      else
        print('验证接口访问失败')
    end
    return false ;
end
function 拆分字符(str)
    local result=nil ;
    local s=str
    pcall(function()
        list1={};
        for i=1,#s do
            list1[i]=string.sub(s,i,i)
        end
        result=list1
    end)
    return result ;
end
function 键盘z(str)
    local zm={
        q={x="66",y="390"},w={x="192",y="390"},e={x="318",y="390"},r={x="444",y="390"}, t={x="570",y="390"},y={x="696",y="390"},
        u={x="822",y="390"},i={x="948",y="390"}, o={x="1074",y="390"},p={x="1200",y="390"},
        a={x="132",y="482"},s={x="258",y="482"},d={x="384",y="482"},f={x="510",y="482"},g={x="636",y="482"},h={x="762",y="482"},
        j={x="888",y="482"},k={x="1014",y="482"},l={x="1140",y="482"},
        z={x="258",y="570"},x={x="384",y="570"},c={x="510",y="570"},v={x="636",y="570"},b={x="762",y="570"},n={x="888",y="570"},
        m={x="1014",y="570"},
    }
    for k , v in pairs(zm) do
        if k==str then
            print(v.x..","..v.y)
            click(tonumber(v.x) , tonumber(v.y))
            sleep(30)
            return true ;
        end
    end
end
function 键盘s(str)
    local ms=str ;
    local zm={
        q={x="66",y="390"},w={x="192",y="390"},e={x="318",y="390"},r={x="444",y="390"}, t={x="570",y="390"},y={x="696",y="390"},
        u={x="822",y="390"},i={x="948",y="390"}, o={x="1074",y="390"},p={x="1200",y="390"},
    }
    if tonumber(str)==1 then
        ms="q"
      elseif tonumber(str)==2 then
        ms="w"
      elseif tonumber(str)==3 then
        ms="e"
      elseif tonumber(str)==4 then
        ms="r"
      elseif tonumber(str)==5 then
        ms="t"
      elseif tonumber(str)==6 then
        ms="y"
      elseif tonumber(str)==7 then
        ms="u"
      elseif tonumber(str)==8 then
        ms="i"
      elseif tonumber(str)==9 then
        ms="o"
      elseif tonumber(str)==0 then
        ms="p"
      else
        return false ;
    end
    for k , v in pairs(zm) do
        if k==ms then
            print("数字键盘:"..v.x..","..v.y)
            click(tonumber(v.x) , tonumber(v.y),850)
            sleep(30)
            return true ;
        end
    end
end

function 邮箱(str)
    print(str)
    if str =="163.com" then
        click(288,138);sleep(60)
      elseif str =="qq.com" then
        click(450,140);sleep(60)
      elseif str =="126.com" then
        click(622,140);sleep(60)
      elseif str =="yeah.net" then
        click(792,142);sleep(60)
      elseif str =="sina.com" then
        click(964,140);sleep(60)
    end
end
-- click(66,390,850)
function inputname(str)
    local sd=str
    sd=split(sd,"@")
    local sds=拆分字符(sd[1])
    for j,m in pairs(sds) do
        键盘z(m)
        键盘s(m)
        sleep(60)
    end
    邮箱(sd[2])
    sleep(200)
    if findColor({763,14,1000,149,"909,72,#828486|903,78,#D3D6D7|879,65,#F9FBFD",95}) then
        print("账号输入完成")
        return true
    end
end
function inputpwd(str)
    local sds=拆分字符(str)
    for j,m in pairs(sds) do
        键盘z(m)
        键盘s(m)
        sleep(60)
    end
    print("密码输入完成")
    return true
end
