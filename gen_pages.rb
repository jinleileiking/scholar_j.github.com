def gen_page dir
    acc_items_nr = 0

    IO.popen("ls -l images/#{dir} | wc -l") { |f| acc_items_nr =  f.gets.to_i - 1}

    puts acc_items_nr

    html = ""
    for nr in 1..acc_items_nr 
        intro = nil
        title = nil
        File.open("images/#{dir}/#{nr}/title","r") do |file|
             title  = file.gets
        end
        File.open("images/#{dir}/#{nr}/intro","r") do |file|
             intro  = file.gets
        end
        html = html + "<h3>#{title}</h3><p>#{intro}</p>"
        Dir["images/#{dir}/#{nr}/*"].each do |file|
            if File.directory? file
                next
            end
            if File.symlink? file
                next
            end

            unless /(?<filename>.+)\.jpg/ =~ file
                next
            end

            if /thumb/ =~ file
                next
            end


            puts "#{file}"

            
    #         puts <img src="./images/1/0317_1_thumb.jpg" class="img-thumbnail" style="width: 140px; height: 140px;" onclick="window.location.href='./images/1/0317_1.jpg'"/>
            html += %Q(<img src="./#{filename}_thumb.jpg" class="img-thumbnail" style="width: 140px; height: 140px;" onclick="window.location.href='./#{file}'"/>\n)
        #     puts "#{filename}"
        #     system "convert #{filename}.jpg -resize 140x140 #{filename}_thumb.jpg"
        end
    end

    File.open("./#{dir}.html","w") do |file|
         file.puts html
    end
end

gen_page("accessories")
gen_page("bodhi")
gen_page("rudraksha")



