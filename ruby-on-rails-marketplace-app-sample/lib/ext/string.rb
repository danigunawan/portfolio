class String

	def clean_name
		return self.first.upcase + self[1..-1] if length > 0
		return self
	end

	def ngclean
		return gsub('number:','').gsub('string:','')
	end

	def numeric?
    return true if self =~ /\A\d+\Z/
    true if Float(self) rescue false
  end

  def boolean?
    return true if self.downcase == 'true' || self.downcase == 'false'
  end

  def to_boolean
    return false if self.downcase == 'false'
    true
  end

  def to_logical
    return self.to_i if self.numeric?
    return self.to_boolean if self.boolean?
    return self
  end

	# Helper function to normalize all caps text input into properly formatted text.
  def normalize(t=0.2)
    if (1.0 - (gsub(/[A-Z]/,'').length / (1.0*length))) >= t
      gsub(/[^.?!]{6,}[.?!]/, '\0|').split(/\|/).collect { |x| x.strip.humanize if x.length > 5 } .join(' ').gsub(' i ', ' I ')
    else
      self
    end
  end


  def eval
    Kernel.eval(self.to_s)
  end

  def add_param_to_uri(param, value)
		value = value.to_s
    return self.to_s if not value or value.empty?
    cleaned_url = self.to_s.remove_param_from_uri(param)
    return cleaned_url.concat("&#{param}=#{URI.encode(value)}") if cleaned_url.match(/(\?.+|\&)/)
    return cleaned_url.concat("#{param}=#{URI.encode(value)}") if cleaned_url.match(/(\?$)/)
    return cleaned_url.concat("?#{param}=#{URI.encode(value)}")
  end

  def remove_param_from_uri(param)
    return self.to_s.gsub(/(\?|\&)#{ param }=[^&]+/,'').gsub("&&",'&').gsub(/(\?|\&)$/,'')
  end

	# Helper function to normalize all caps text input into properly formatted text.
  def normalize
    gsub(/[^.?!]{6,}[.?!]/, '\0|').split(/\|/).collect { |x| x.strip.humanize if x.length > 5 } .join(' ')
  end

	# levenshtein_distance helper function where t is the string to compare.
	# source: http://stackoverflow.com/questions/16323571/measure-the-distance-between-two-strings-with-ruby
  def distance(t)
  	s = self.to_s
    m = s.length
    n = t.length
    return m if n == 0
    return n if m == 0
    d = Array.new(m+1) {Array.new(n+1)}

    (0..m).each {|i| d[i][0] = i}
    (0..n).each {|j| d[0][j] = j}
    (1..n).each do |j|
      (1..m).each do |i|
        d[i][j] = if s[i-1] == t[j-1]  # adjust index into string
					          d[i-1][j-1]       # no operation required
					        else
					          [ d[i-1][j]+1,    # deletion
					            d[i][j-1]+1,    # insertion
					            d[i-1][j-1]+1,  # substitution
					          ].min
					        end
      end
    end
    d[m][n]
  end

  def self.random(length)
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    return (0...length).map { o[rand(o.length)] }.join
  end
end
