module ImageProcessor
  class Badge
    attr_accessor :achieved_id, :image_path, :result_path, :image, :full_name, :about, :avatar, :badge_image, :badge_name, :badge_description, :avatar_circle, :avatar_100, :badge_100, :text1_path, :text2_path
    
    def remove_tmp_image
      `rm #{@result_path}`
    end

    def remove_composite_images
      `rm #{@avatar_100}`
      `rm #{@avatar_circle}`
      `rm #{@badge_100}`
      `rm #{@text1_path}`
      `rm #{@text2_path}`
    end
    

    def tmp_path
      ENV["BADGE_TMP_PATH"] || "/tmp"
    end

    def initialize achieved_id
      @achieved_id = achieved_id
      achieved_badge = AchievedBadge.find achieved_id
      
      @full_name = achieved_badge.user.full_name rescue ""
      @about = achieved_badge.user.about rescue ""
      @avatar = achieved_badge.user.avatar.thumbnail_square.url rescue Rails.root.join("public/images/placeholder1.png")

      @badge_image = achieved_badge.badge.image.url rescue Rails.root.join("public/images/placeholder1.png")
      @badge_name = achieved_badge.badge.name
      @badge_description = achieved_badge.badge.description

      @image_path = Rails.root.to_s + "/public/images/badge.png"
      @result_path = Rails.root.to_s + "#{tmp_path}/#{achieved_id}.png"
      @image = MiniMagick::Image.open(@image_path)

      @image = user_detail
      @image = badge_detail 

      @image.write(@result_path)
      remove_composite_images
    end


    # image manipulation

    def user_detail
      @image = user_avatar if @avatar.present?
      @image = user_fullname
      @image = user_about
    end

    def avatar_url
      @avatar_100 = Rails.root.to_s + "#{tmp_path}/avatar_#{@achieved_id}_100.png"
      @avatar_circle = Rails.root.to_s + "#{tmp_path}/avatar_#{@achieved_id}.png"
      url = Rails.env.development? ? Rails.root.join("public/images/placeholder.png") : @avatar
      
      image = MiniMagick::Image.open(url)
      image.resize "80x80"
      image.format "png"
      image.write @avatar_100

      MiniMagick::Tool::Convert.new do |img|
        img.size "80x80"
        img <<   'xc:transparent'
        img.fill @avatar_100
        img.draw "translate 40, 40 circle 0,0 40,0"
        img.trim
        img << @avatar_circle
      end
      @avatar_circle
    end

    def user_avatar
      @image.composite(MiniMagick::Image.new(avatar_url)) do |c|
        c.compose "Over"    
        c.geometry "+0+160"
        c.gravity 'North'
      end
    end

    def user_fullname
      @image.combine_options do |c|
        c.font Rails.root.to_s + '/public/fonts/Lato/Lato-Bold.ttf'
        c.gravity 'North'
        
        c.fill '#212121'
        c.pointsize '30'
        c.draw "text 0, 270 '#{@full_name}'"
      end
    end

    def user_about
      text_about @about
      @image.composite(MiniMagick::Image.new(@text2_path)) do |c|
        c.compose "Over"    
        c.geometry "+0+290"
        c.gravity 'North'
      end
    end

    def text_about fulltext
      @text2_path = Rails.root.to_s + "#{tmp_path}/text2_#{@achieved_id}.png"

      convert = MiniMagick::Tool::Convert.new
      convert.size "700x100"
      convert.background 'transparent'
      convert.font Rails.root.to_s + '/public/fonts/Lato/Lato-Regular.ttf'
      convert.fill '#4f4f4f'
      convert.pointsize '24'
      convert.gravity 'Center'
      convert << 'caption: ' + (fulltext || "")
      
      convert << @text2_path
      convert.call
    end
    
    
    

    def badge_detail
      @image = badge_img if @badge_image.present?
      @image = write_badge_name
      @image = write_badge_description
    end

    def badge_img
      url = Rails.env.development? ? Rails.root.join("public/images/badge_placeholder.png") : @badge_image

      @badge_100 = Rails.root.to_s + "#{tmp_path}/badge_#{@achieved_id}_100.png"

      image = MiniMagick::Image.open(url)
      image.resize "250x250"
      image.format "png"
      image.write @badge_100
      
      @image.composite(MiniMagick::Image.new(@badge_100)) do |c|
        c.compose "Over"    
        c.geometry "+0+400"
        c.gravity 'North'
      end
    end

    def write_badge_name
      @image.combine_options do |c|
        c.font Rails.root.to_s + '/public/fonts/Lato/Lato-Bold.ttf'
        c.gravity 'North'
        
        c.fill '#f4f4f4'
        c.pointsize '48'
        c.draw "text 0, 680 '#{@badge_name}'"
      end
    end

    def write_badge_description
      text_description @badge_description
      @image.composite(MiniMagick::Image.new(@text1_path)) do |c|
        c.compose "Over"    
        c.geometry "+0+730"
        c.gravity 'North'
      end
    end
    

    def text_description fulltext
      @text1_path = Rails.root.to_s + "#{tmp_path}/text_#{@achieved_id}.png"

      convert = MiniMagick::Tool::Convert.new
      convert.size "700x100"
      convert.background 'transparent'
      convert.font Rails.root.to_s + '/public/fonts/Lato/Lato-Regular.ttf'
      convert.fill '#f4f4f4'
      convert.pointsize '28'
      convert.gravity 'Center'
      convert << 'caption: ' + (fulltext || "")
      
      convert << @text1_path
      convert.call
    end
    
    

  end
end