gemspec = Gem::Specification.load("./#{Dir["*.gemspec"].first}")

def write_file filepath, &b
  filepath.split("/").reduce do |path, next_part|
    Dir.mkdir path if not Dir.exist? path
    "#{path}/#{next_part}"
  end
  File.open filepath, "w", &b
end

def base_dir
  dir = Dir.getwd
  dir.end_with?("maintain") ? File.dirname(dir) : dir
end

def compile_rbmd input_file, output_file, gemspec
  write_file output_file do |f|
    File.foreach input_file do |line|
      if line =~ /#\[(.*)\]/
        f << "```RUBY\n"
        File.foreach "#{base_dir}/#{$1}" do |line|
          f << line
        end
        f << "\n```\n"
      else
        f << line.gsub(/\#{.*}/){|group| eval group[2...-1], binding }
      end
    end
  end
end

compile_rbmd "#{base_dir}/doc/draft/wiki.rbmd", "#{base_dir}/doc/wiki/README.md", gemspec
compile_rbmd "#{base_dir}/doc/draft/readme.rbmd", "#{base_dir}/README.md", gemspec
