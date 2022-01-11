*** Settings ***
Library             AppiumLibrary

*** Variables ***
${songList}         id=com.ecarx.multimedia:id/playlist_detail_rv      #歌曲列表
${login_message}      id=com.ecarx.multimedia:id/tv_confirm_message      # 登录提示弹窗
${cancel_login }      id=com.ecarx.multimedia:id/tv_dialog_left_btn      #取消登录
${confirm_login}      id=com.ecarx.multimedia:id/tv_dialog_right_btn      #确认登录

*** Keywords ***
打开多媒体
      comment      打开多媒体
      Open Application      http://127.0.0.1:4723/wd/hub      platformName=Android      platformVersion=9      deviceName=5ddfd034      appPackage=com.ecarx.multimedia      appActivity=com.ecarx.multimedia.MainActivity      resetKeyboard=true      noReset=true
      sleep      2

退出多媒体
      Close Application

点击精选内容
      click element      id=com.ecarx.multimedia:id/main_tab_handpick

点击精选音乐
      click element      xpath=//android.widget.LinearLayout[@content-desc="精选音乐"]

点击精选听书
      click element      xpath=//android.widget.LinearLayout[@content-desc="精选听书"]

返回精选音乐精选听书
      [Documentation]      从精选歌曲返回精选音乐；从精选专辑返回精选听书
      comment      点击返回按钮
      click element      com.ecarx.multimedia:id/common_back

向左滑动屏幕5s
      comment      向左滑动屏幕5秒
      Swipe      1800      600      800      600      5000

向右滑动屏幕5s
      comment      向右滑动屏幕5秒
      Swipe      800      600      1800      600      5000

向上滑动播放列表
      swipe      1500      1000      1500      180      5000

查看登录状态
      打开精选音乐
      comment      点击我的按钮
      click element      com.ecarx.multimedia:id/common_avatar
      comment      断言：页面包含登录按钮元素
      ${login_status}      Run Keyword And Return Status      Page Should Contain Element      com.ecarx.multimedia:id/login

取消登录
      comment      登录提示选择取消登录
      click element      id=com.ecarx.multimedia:id/tv_dialog_left_btn

点击账号登录
      comment      登录提示选择账号登录
      Wait Until Page Contains Element
      click element      ${confirm_login}

获取播放模式toast文本

播放歌曲
      click element      xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.ecarx.multimedia:id/handpick_music_rv"]/android.widget.FrameLayout[2]      #网络古风
      Wait Until Element Is Visible      xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.ecarx.multimedia:id/playlist_detail_rv"]/android.widget.LinearLayout[3]      #列表第二首
      click element      xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.ecarx.multimedia:id/playlist_detail_rv"]/android.widget.LinearLayout[3]      #列表第二首

点击mini收藏按钮
      click element      ${mini_player_collect}

进入播放详情页
      click element      id=com.ecarx.multimedia:id/mini_player_enter      #mini播放界面的放大按钮
      Wait Until Element Is Visible      id=com.ecarx.multimedia:id/full_player_collect      #播放详情页收藏按钮

退出播放详情
      click element      com.ecarx.multimedia:id/full_player_back      #详情页返回按钮

搜索播非VIP歌曲
      ${full_player_download}      Set Variable      id=com.ecarx.multimedia:id/full_player_download
      ${common_search}      Set Variable      id=com.ecarx.multimedia:id/common_search      #搜索按钮
      ${input_search}      Set Variable      id=com.ecarx.multimedia:id/input_edt      #搜索输入框
      ${search_btn}      Set Variable      id=com.ecarx.multimedia:id/search_btn      #执行搜索
      ${search_keyword}      Set Variable      王一博山河星光      #搜索关键词
      ${search_result}      Set Variable      id=com.ecarx.multimedia:id/recycler_view      #搜索结果列表
      ${choose_song}      Set Variable      xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.ecarx.multimedia:id/recycler_view"]/android.widget.LinearLayout[2]
      #搜索结果第一个元素
      ${clear_search_keyword}      Set Variable      id=com.ecarx.multimedia:id/iv_del
      comment      点击进入搜索页
      click element      ${common_search}
      ${keywords_hava}      Run Keyword And Return Status      Page Should Contain Element      ${clear_search_keyword}
      run keyword if      "${keywords_hava}"=="true"      click element      ${clear_search_keyword}
      ...      ELSE IF      "${keywords_hava}"=="false"      Run Keywords
      comment      点击元素放入输入光标
      Input Text      ${input_search}      ${search_keyword}
      sleep      2
      Click Element      ${search_btn}
      sleep      3
      Wait Until Element Is Visible      ${search_result}
      click element      ${choose_song}
      sleep      5

搜索播放VIP歌曲
      ${full_player_download}      Set Variable      id=com.ecarx.multimedia:id/full_player_download
      ${common_search}      Set Variable      id=com.ecarx.multimedia:id/common_search      #搜索按钮
      ${input_search}      Set Variable      id=com.ecarx.multimedia:id/input_edt      #搜索输入框
      ${search_btn}      Set Variable      id=com.ecarx.multimedia:id/search_btn      #执行搜索
      ${search_keyword}      Set Variable      周杰伦安静      #搜索关键词
      ${search_result}      Set Variable      id=com.ecarx.multimedia:id/recycler_view      #搜索结果列表
      ${choose_song}      Set Variable      xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.ecarx.multimedia:id/recycler_view"]/android.widget.LinearLayout[2]
      #搜索结果第一个元素
      ${clear_search_keyword}      Set Variable      id=com.ecarx.multimedia:id/iv_del
      comment      点击进入搜索页
      click element      ${common_search}
      ${keywords_hava}      Run Keyword And Return Status      Page Should Contain Element      ${clear_search_keyword}
      run keyword if      "${keywords_hava}"=="true"      click element      ${clear_search_keyword}
      ...      ELSE IF      "${keywords_hava}"=="false"      Run Keywords
      comment      点击元素放入输入光标
      Input Text      ${input_search}      ${search_keyword}
      sleep      2
      Click Element      ${search_btn}
      sleep      3
      Wait Until Element Is Visible      ${search_result}
      click element      ${choose_song}
      sleep      5

搜索播放付费书单
      ${full_player_download}      Set Variable      id=com.ecarx.multimedia:id/full_player_download
      ${common_search}      Set Variable      id=com.ecarx.multimedia:id/common_search      #搜索按钮
      ${input_search}      Set Variable      id=com.ecarx.multimedia:id/input_edt      #搜索输入框
      ${search_btn}      Set Variable      id=com.ecarx.multimedia:id/search_btn      #执行搜索
      ${search_keyword}      Set Variable      小探险家双语百科      #搜索关键词
      ${search_result}      Set Variable      id=com.ecarx.multimedia:id/recycler_view      #搜索结果列表
      ${choose_book}      Set Variable      xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.ecarx.multimedia:id/recycler_view"]/android.view.ViewGroup[1]      #搜索结果第一个元素
      ${clear_search_keyword}      Set Variable      id=com.ecarx.multimedia:id/iv_del
      comment      点击进入搜索页
      click element      ${common_search}
      ${keywords_hava}      Run Keyword And Return Status      Page Should Contain Element      ${clear_search_keyword}
      run keyword if      "${keywords_hava}"=="true"      click element      ${clear_search_keyword}
      ...      ELSE IF      "${keywords_hava}"=="false"      Run Keywords
      comment      输入关键词
      Input Text      ${input_search}      ${search_keyword}
      sleep      2
      Click Element      ${search_btn}
      sleep      3
      Wait Until Element Is Visible      ${search_result}
      comment      选中搜索结果的类型
      ${result_type_book}      Set Variable      xpath=//android.widget.LinearLayout[@content-desc="听书"]
      click element      ${result_type_book}
      Wait Until Element Is Visible      ${search_result}
      click element      ${choose_book}
      sleep      5

退出搜索页面
      ${cancel_search}      Set Variable      id=com.ecarx.multimedia:id/cancel_btn
      click element      ${cancel_search}

取消恢复上次听到的章节
      ${login_message_have}      Run Keyword And Return Status      Page Should Contain Element      id=com.ecarx.multimedia:id/tv_confirm_message
      Run Keyword If      ${login_message_have}==${TRUE}      click element      id=com.ecarx.multimedia:id/tv_dialog_left_btn
      ...      ELSE IF      ${login_message_have}==${FALSE}      Run Keywords

下载列表返回精选内容主页
      click element      com.ecarx.multimedia:id/common_back      #下载列表返回我的
      click element      com.ecarx.multimedia:id/common_back      #我的返回精选内容主页

判断是否已返回精选内容
      ${common_back}      Run Keyword And Return Status      Page Should Contain Element      com.ecarx.multimedia:id/common_back
      Run Keyword If      ${common_back}==${TRUE}      Click Element      com.ecarx.multimedia:id/common_back
      ...      ELSE IF      ${common_back}==${FALSE}      Run Keywords

刷新并等待
      click element      com.ecarx.multimedia:id/tv_load_retry      #点击刷新按钮
      sleep      5

刷新网络
      ${res}      Run Keyword And Return Status      Page Should Contain Element      com.ecarx.multimedia:id/error_info      #加载失败，请检查网络设置
      run keyword if      ${res} == ${TRUE}      刷新并等待
      ...      ELSE IF      ${res} == ${FALSE}      Run Keywords

判断听书会员弹窗
      ${login_message_have}      Run Keyword And Return Status      Page Should Contain Element      id=com.ecarx.multimedia:id/fl_dialog_content
      run keyword if      ${login_message_have}==${TRUE}      click element      com.ecarx.multimedia:id/tv_dialog_left_btn
      ...      ELSE IF      ${login_message_have}==${FALSE}      Run Keywords

判断试听歌曲弹窗
      ${message}      Run Keyword And Return Status      Page Should Contain Element      com.ecarx.multimedia:id/ll_content_container
      Run Keyword If      ${message} == ${TRUE}      click element      com.ecarx.multimedia:id/cancel
      ...      ELSE IF      ${message} == ${FALSE}      RUN KEYWORDS

点击"我的"
      click element      id=com.ecarx.multimedia:id/common_avatar      #我的按钮

点击“我的-下载”
      click element      id=com.ecarx.multimedia:id/mine_download      #我的-下载

点击我的界面返回键
      comment      通用此元素返回：我的、我的-收藏、我的-历史、我的-已购、我的-下载
      click element      com.ecarx.multimedia:id/common_back

取消试听
      click element      id=com.ecarx.multimedia:id/cancel      #试听片段，订阅音乐包可畅听

清除缓存和下载记录
      点击"我的"
      sleep      3
      click element      com.ecarx.multimedia:id/about
      sleep      2
      click element      com.ecarx.multimedia:id/clear_cache
      comment      返回主界面
      点击我的界面返回键
      sleep      2
      点击“我的-下载”
      ${loadlist}      Run Keyword And Return Status      Page Should Contain Element      com.ecarx.multimedia:id/empty_text
      Run Keyword If      ${loadlist}==${FALSE}      清除下载记录
      ...      ELSE IF      ${loadlist}==${TRUE}      Run Keywords
      sleep      2
      点击我的界面返回键
      sleep      2
      点击我的界面返回键

清除下载记录
      click element      com.ecarx.multimedia:id/edit      #点击编辑
      click element      com.ecarx.multimedia:id/choose_all      #点击全选
      click element      com.ecarx.multimedia:id/delete      #点击删除
      sleep      2
      click element      com.ecarx.multimedia:id/tv_dialog_right_btn      #删除弹窗，点确认删除
