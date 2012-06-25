#encoding: utf-8
module ApplicationHelper
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
  def is_ie?
    request.env["HTTP_USER_AGENT"] =~ /MSIE.*6.*Windows NT/i
  end

  def title(page_title)
  	content_for(:title){ page_title}
  end
  def meta_keywords(meta_keywords)
  	content_for(:meta_keywords){ meta_keywords}
  end
  def meta_description(meta_description)
  	content_for(:meta_description){ meta_description}
  end
  def next_nav(name, link)
    content_for(:next_nav){ link_to(name, link)}
  end

  def need_show_cart
    ha={
      'welcome' =>['index'],
      'shops' => ['index', 'show']
    }
    return true if ha.include?(params[:controller]) && ha[params[:controller]].include?(params[:action])
    false
  end
  #
  def current_class(name)
    if params.values.join(' ') =~ /\b#{name}/i
      return ' class = "current"'.html_safe
    end
    ''
  end
  
  def get_dish_cart_li(shop_id, shop_dish_id, name, price, count)
    "<li id='cart_shop_dish_#{shop_dish_id}'>#{name.ljust(15, '一').gsub(/([一]+)/, '<span style=\'color:#7cc130;\'>\1</span>')} #{price.to_s.rjust(2, '0').gsub(/^([0])/, '<span style=\'color:#7cc130;\'>\1</span>') || '0.0' } x #{count.to_s || '1' }&nbsp;&nbsp;<a href='/delete_cart?shop_id=#{shop_id}&shop_dish_id=#{shop_dish_id}' data-remote='true' class='button_del'><span style='color:#fff;'>x</span></a></li>".html_safe
  end
  #链接菜单导航，如：首页/关于我们
  #input: nav_bar [['首页', '/'], ['关于', '/about']]
  def nav_bar(bar_arr)
    strs = ['<div id="nav_bar">']
    bar_arr.each do |nav|
      strs << link_to(nav[0], nav[1], :class=> 'nav_bar_link')
      strs << " / "
    end
    strs << "</div>"
    content_for(:nav_bar){
      strs.join.html_safe
    }
  end
  

  def truncate_content(content, count)
    strip_tags(content).to_s.gsub(/[ ]+|\s+|\t+|\n+/, ' ').truncate(count)
  end
  #flash动画显示
  # eg: play_flash("flash/top_banner.swf")
  # or: play_flash asset_path("flash/top_banner.swf"), :width => '985', :height => '249'
  def play_flash(src, options = {:width=>'600', :height=>'400'})
    str = "<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' width='"+ options[:width] +"' height='"+ options[:height] +"' id='FlashID' accesskey='1' tabindex='1' title='omero'>
        <param name='movie' value='" + src + "' />
        <param name='quality' value='high' />
        <param name='wmode' value='transparent' />
        <param name='swfversion' value='9.0.45.0' />
        <param name='expressinstall' value='" + asset_path('Scripts/expressInstall.swf') + "' />
        <!--[if !IE]>-->
        <object type='application/x-shockwave-flash' data='" + src + "' width='"+  options[:width] +"' height='"+  options[:height] +"'>
          <!--<![endif]-->
          <param name='movie' value='" + src + "' />
          <param name='quality' value='high' />
          <param name='wmode' value='transparent' />
          <param name='swfversion' value='9.0.45.0' />
          <param name='expressinstall' value='"+ asset_path('Scripts/expressInstall.swf') + "' />
          <div>
            <h4>此页面上的内容需要较新版本的 Adobe Flash Player。</h4>
            <p><a href='http://www.adobe.com/go/getflashplayer'><img src='http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='获取 Adobe Flash Player' width='112' height='33' /></a></p>
          </div>
          <!--[if !IE]>-->
        </object>
        <!--<![endif]-->
      </object>"
    return str.html_safe
  end

end
