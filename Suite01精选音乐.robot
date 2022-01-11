*** Settings ***
Documentation       精选音乐歌曲分类列表，歌曲列表
Suite Setup         打开多媒体
Suite Teardown      退出多媒体
Library             AppiumLibrary
Resource            精选内容关键字.resource

*** Variables ***
${featured}         id=com.ecarx.multimedia:id/main_tab_handpick      # 精选内容id
${selected_musicList}      id=com.ecarx.multimedia:id/handpick_music_rv      # 精选音乐界面歌曲分类列表id
${songList}         id=com.ecarx.multimedia:id/playlist_detail_rv      # 精选歌单页面歌曲列表id
${mini_playing_title}      id=com.ecarx.multimedia:id/mini_player_song_name      #正在播放的歌曲书章节标题
${full_playing_title}      id=com.ecarx.multimedia:id/full_player_song_name      #正在播放的歌曲/书章节标题
${player_quality}      id=com.ecarx.multimedia:id/full_player_quality      # 播放详情页音质选项框
${login_message}      id=com.ecarx.multimedia:id/tv_confirm_message      # 登录账号提示窗

*** Test Cases ***
SM_001打开精选内容进入精选音乐
      [Tags]      精选音乐
      sleep      3
      点击精选内容
      Wait Until Element Is Visible      ${selected_musicList}      10
      Page Should Contain Element      ${selected_musicList}

SM_002滑动歌曲分类列表
      [Tags]      精选音乐      滑动
      comment      滑动歌曲分类列表
      向左滑动屏幕5s
      sleep      2
      向右滑动屏幕5s
      sleep      2
      comment      断言:歌曲分类列表元素仍存在
      Page Should Contain Element      ${selected_musicList}

SM_003点击任意分类进入歌单
      [Tags]      精选音乐
      comment      确认列表加载完成
      Wait Until Element Is Visible      ${selected_musicList}
      comment      点击分类第一个歌单
      Click element      xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.ecarx.multimedia:id/handpick_music_rv"]/android.widget.FrameLayout[1]
      sleep      3
      comment      断言：歌曲列表元素应存在
      Page Should Contain Element      ${songList}

SM_004滑动歌曲列表
      [Tags]      精选音乐      滑动
      comment      左右滑动歌曲列表
      向左滑动屏幕5s
      sleep      2
      向右滑动屏幕5s
      sleep      2
      comment      断言：歌曲列表元素仍存在
      Page Should Contain Element      ${songList}

SM_013退出歌曲列表返回精选音乐
      [Tags]      精选音乐
      comment      返回精选音乐界面
      返回精选音乐精选听书
      log      已返回精选音乐
      sleep      3
      comment      断言：页面包含歌曲分类的元素
      Page Should Contain Element      ${selected_musicList}

SM_005点击播放非VIP歌曲
      [Tags]      精选音乐      播放
      判断是否已返回精选内容
      comment      打开歌曲列表
      ${song_type2}      Set Variable      xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.ecarx.multimedia:id/handpick_music_rv"]/android.widget.FrameLayout[2]      #分类网络古风
      click element      ${song_type2}
      Wait Until Element Is Visible      ${songList}
      comment      获取第一首歌的歌名
      ${click_song_name}      Get Text      xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.ecarx.multimedia:id/playlist_detail_rv"]/android.widget.LinearLayout[2]/android.widget.CheckedTextView
      comment      播放第一首歌
      click element      xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.ecarx.multimedia:id/playlist_detail_rv"]/android.widget.LinearLayout[2]      #第一首歌xpath
      sleep      2
      comment      获取当前播放的歌名
      ${playing_song_name}      Get Text      ${mini_playing_title}
      Should Be Equal      ${playing_song_name}      ${click_song_name}
      返回精选音乐精选听书

SM_006点击播放VIP歌曲
      [Tags]      精选音乐      播放
      判断是否已返回精选内容
      comment      点击旅行驾驶
      click element      xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.ecarx.multimedia:id/handpick_music_rv"]/android.widget.FrameLayout[5]
      Wait Until Element Is Visible      ${songList}
      comment      点击歌曲“旅行”
      Click element      xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.ecarx.multimedia:id/playlist_detail_rv"]/android.widget.LinearLayout[4]
      Wait Until Element Is Visible      id=com.ecarx.multimedia:id/ll_content_container      10
      comment      断言：页面弹窗提示
      Page Should Contain Element      id=com.ecarx.multimedia:id/ll_content_container
      comment      合并执行SM_007取消登录
      click element      id=com.ecarx.multimedia:id/cancel      #试听片段取消按钮
      comment      弹窗消失
      Page Should Not Contain Element      id=com.ecarx.multimedia:id/ll_content_container
      返回精选音乐精选听书

SM_007点击播放VIP歌曲取消登录
      [Tags]      精选音乐      播放
      comment      合并到SM_006执行

SM_008点击播放VIP歌曲点击登录
      [Tags]      账号登录      精选音乐      播放
      comment      暂不执行

SM_009歌单全部播放
      [Tags]      精选音乐      播放
      判断是否已返回精选内容
      Wait Until Element Is Visible      ${selected_musicList}      10
      comment      点击第歌单分类第4个类型
      click element      xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.ecarx.multimedia:id/handpick_music_rv"]/android.widget.FrameLayout[4]
      sleep      2
      comment      获取列表第一首歌歌名
      ${first_song_name}      Get Text      xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.ecarx.multimedia:id/playlist_detail_rv"]/android.widget.LinearLayout[2]/android.widget.CheckedTextView
      Log To Console      ${first_song_name}
      comment      点击全部播放
      click element      id=com.ecarx.multimedia:id/playlist_detail_all_play
      comment      获取当前播放的歌名
      ${playing_song_name}      Get Text      ${mini_playing_title}
      Log To Console      ${playing_song_name}
      Should Be Equal      ${first_song_name}      ${playing_song_name}
      Run Keyword And Ignore Error      返回精选音乐精选听书

SM_010歌单页收藏
      [Tags]      精选音乐      收藏
      判断是否已返回精选内容
      click element      xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.ecarx.multimedia:id/handpick_music_rv"]/android.widget.FrameLayout[2]      #分类网络古风
      sleep      5
      sleep      3
      click element      id=com.ecarx.multimedia:id/playlist_detail_collect      #歌单页收藏按钮
      Page Should Contain Element      ${login_message}
      comment      合并执行SM_011收藏取消登录
      click element      id=com.ecarx.multimedia:id/tv_dialog_left_btn
      comment      取消后弹窗消失
      Page Should Not Contain Element      ${login_message}
      Run Keyword And Ignore Error      返回精选音乐精选听书

SM_011歌单页收藏取消登录
      [Tags]      精选音乐      收藏
      comment      合并到SM_010一起执行

SM_012歌单页收藏点击登录
      [Tags]      账号登录      精选音乐      收藏
      Wait Until Element Is Visible      ${selected_musicList}      10
      comment      进入任意书单
      ${song_type2}      Set Variable      xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.ecarx.multimedia:id/handpick_music_rv"]/android.widget.FrameLayout[2]      #分类网络古风
      Click Element      ${song_type2}
      Wait Until Element Is Visible      ${songList}
      click element      id=com.ecarx.multimedia:id/playlist_detail_collect
      ${login_message_have}      Run Keyword And Return Status      Page Should Contain Element      ${login_message}      #弹窗：尚未登录账号
      comment      有弹窗账号登录 没弹窗log提示
      Run Keyword If      ${login_message_have}==${TRUE}      click element      id=com.ecarx.multimedia:id/tv_dialog_right_btn
      ...      ELSE IF      ${login_message_have}==${FALSE}      LOG      没有弹窗      #账号登录
      comment      断言：进入账号登录界面

123
      ${/}
