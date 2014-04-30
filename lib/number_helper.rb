#this helps with any number or math related functions
module NumberHelper
  
  
  def self.logger
   Rails.logger
  end
  
  def self.get_javascript_date( date )
    if  date.class.to_s == "DateTime"
      
    end
    
    #if it is a Date object convert date
    if  date.class.to_s == "Date"
      date = date.to_datetime
    end
    
    y = date.strftime( "%Y")
    m = date.strftime( "%m").to_i - 1 #convert the month 
    m = m.to_s
    d = date.strftime( "%d")
    
    return "#{y}, #{m}, #{d}"
    
  end
  
  #generate a random id
  def self.random_number

    #hash the current time
    currentTime = Time.now.to_s
    logger.debug( currentTime )
    randomNumber = rand( 1000000 )     
    prefixFile = Digest::SHA1.hexdigest( currentTime ) + randomNumber.to_s
    
    NumberHelper.logger.debug( "PREFIX" + prefixFile )
    return prefixFile
    
  end
  
  #gets a random code
  def self.get_random_code( length )
    
    #generate a very random string
    random_word = Time.now.to_s + Time.now.to_f.to_s + rand( 1000000 ).to_s
    Digest::SHA1.hexdigest( random_word  ).slice(0..length)
  end
  
  #given any date, it gets the date of the beginning of the week
  #for example if wednesday is passed in, Sunday is returned
  def self.get_start_of_week( date )
    
      #get the commercial day of week (0-6)
      cal_day_of_week = date.strftime( '%w').to_i
      start_of_week = date - cal_day_of_week.days
      
      return start_of_week
  end
  
  #helper method to get the start week as a key
  #key is yyyymmdd
  def self.get_start_of_week_as_key( date )
      start_week = NumberHelper.get_start_of_week( date )
      
      #we then convert the date into the key into the table which is yyyymmdd
      return start_week.to_s( :yyyymmdd).to_i
      
  end
  
  #given any date, it gets the date of the end of the week
  #for example if wednesday is passed in, Saturday is returned
  def self.get_end_of_week( date )
    
      NumberHelper.logger.debug( "date in end of week: #{date.inspect}")
      #get the commercial day of week (0-6)
      cal_day_of_week = date.strftime( '%w').to_i
      
      #get the offset (we subtract one week to get the
      #number of days we want to offset from. 
      offset = 6 - cal_day_of_week 
      
      NumberHelper.logger.debug( "offset value: #{offset}")
      end_of_week = date + offset.days
      
      NumberHelper.logger.debug( "end of week value: #{end_of_week}")
      
      return end_of_week
  end    
end