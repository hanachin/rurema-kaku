require 'bitclust'
require 'open3'
require 'shellwords'

rurema_root = 'doctree'
directories %W(#{rurema_root}/refm/api/src public)

def generate_rdoc(rd_path)
  o, s = Open3.capture2e('git diff -U0 ' + rd_path.shellescape)

  unless s.success?
    puts o
    return
  end

  return unless m = o.match(/@@ -\d+(?:,\d+)? \+(\d+)(?:,\d+)? @@/)

  changed_line = m[1].to_i + 1 # @sinceなどで変更の1行目がコメントアウトされているとうまくメソッド名を探せないので+1しておく
  prev = File.foreach(rd_path).take(changed_line)
  method = prev.reverse_each.detect { |line| line.start_with?('---') }
  method = BitClust::MethodSignature.parse(method).name if method
  klass = prev.reverse_each.detect do |line|
    next unless line.start_with?('= ')
    m = line.match(/^= (?:class|module) ([^ \n]+) ?/)
    break m && m[1]
  end
  target = prev.reverse_each.detect do |line|
    next unless line.start_with?('== ')
    if line.include?('Singleton Methods') || line.include?('Class Methods')
      break "#{klass}.#{method}"
    elsif line.include?('Instance Methods') || line.include?('== Methods')
      break "#{klass}##{method}"
    elsif line.include?('Constants')
      break "#{klass}::#{method}"
    else
      break
    end
  end

  template = File.join(__dir__, 'template').shellescape
  if klass && method && target
    o, s = Open3.capture2e('bitclust htmlfile --baseurl=http://localhost:9292 --templatedir=' + template + ' --target=' + target.shellescape + ' --ruby=2.4.0 ' + rd_path.shellescape)
    raise "Please report the issue: target=#{target}\n#{o}" unless s.success?
  else
    o, s = Open3.capture2e('bitclust htmlfile --baseurl=http://localhost:9292 --templatedir=' + template + ' --ruby=2.4.0 ' + rd_path.shellescape)
  end

  File.write(File.join(__dir__, 'public', 'index.html'), o)
end

watch(%r{^#{rurema_root}/(?<rd_path>.*)}) do |m|
  Dir.chdir(rurema_root) do
    generate_rdoc(m[:rd_path]) unless File.basename(m[:rd_path]).start_with?('.')
  end
end

guard(:livereload) do
  watch('public/index.html')
end

guard(:rack)


File.write(File.join('public', 'index.html'), <<HTML)
<html>
  <head><title>るりま書く</title></head>
  <body>るりま書く</body>
</html>
HTML
