namespace :glyphs do
  task :compile do
    puts "Remove existing glyph file"
    %x{rm app/assets/stylesheets/components/_fontcustom.scss}

    puts "Comiling glyphs lib/font-glyphs/*.SVG"
    %x(fontcustom compile lib/font-glyphs/)

    puts "Copying new fonts to app/assets/fonts"
    %x(cp -f lib/font-glyphs/fonts/meteocons.* app/assets/fonts)

    puts "Copying SCSS glyph declarations file to app/assets/stylesheets/components/_fontcustom.scss"
    %x{cp -f lib/font-glyphs/fonts/_fontcustom.scss app/assets/stylesheets/components/_fontcustom.scss}

    puts "Removing @font-face lines from app/assets/stylesheets/components/_fontcustom.scss"
    %x{sed -i.bak '5,14d' app/assets/stylesheets/components/_fontcustom.scss}
    %x{rm app/assets/stylesheets/components/_fontcustom.scss.bak}
  end
end