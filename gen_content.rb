
puts "rm thumbs"

system("find . -name \"*thumb*\" | xargs rm")


puts "gen thumbs ..."

Dir['images/**/*'].each do |file|
    if File.directory? file
        next
    end
    if File.symlink? file
        next
    end

    unless /(?<filename>.+)\.jpg/ =~ file
        next
    end

#     puts "#{file}"
#     puts "#{filename}"
    system "convert #{filename}.jpg -resize 140x140 #{filename}_thumb.jpg"

end

puts "gen thumbs done"
