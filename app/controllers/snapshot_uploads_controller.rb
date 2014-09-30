class SnapshotUploadsController < ApplicationController

  def wkhtmltopdf
    file_name = params[:file]
    
    
    s3 = AWS::S3.new
   # args = "--page-height 279 --page-width 210 -O landscape -B 0mm -L 3mm -R 10mm -T 8mm -d 300"
    
    args = params["args"]
# Upload a file.  
    key = File.basename("test.html")        
    bucket_name = "danrailstest"
    s3.buckets[bucket_name].objects[key].write(:file => file_name, :acl=>:public_read)
    
    url = "http://s3.amazonaws.com/danrailstest/test.html"
    
  # wkhtmltopdf-012 --page-height 279 --page-width 210 -O landscape -B 0mm -L 3mm -R 10mm -T 8mm -d 300 http://127.0.0.1:3000/timeline small.pdf
     output_path = "#{Dir::tmpdir}/#{NumberHelper.get_random_code(5)}.pdf"
   
    command = "wkhtmltopdf-012  #{url} #{output_path}"
    
    logger.debug "command being run '#{command}'"
    
    #generate file 
    output = `#{command}`
    
    logger.debug "**command run"
    logger.debug "output: #{output}"
    
    #pdf jam
  
    
    
    #check if file exists
    
     if File.exists? output_path
       
     send_file output_path, :type => 'application/pdf', :filename =>"file.pdf", :disposition=>"attachment"
     
     else
       flash.alert = "That file could not be generated"
       redirect_to snapshot_uploads_path
       
    end
 end
      
end
