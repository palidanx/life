class SnapshotsController < ApplicationController
  
  def calendar_phantomjs
    url = params[:url]
    
#     phantomjs-197 --ignore-ssl-errors=yes util/disney/rasterize.js http://127.0.0.1:3000/timeline test.pdf 1000 1000 1

    if url.blank?
      flash.alert = "Please enter a url"
      redirect_to snapshots_path 
      return
    end
    
    command_path = "#{Rails.root.to_s}/lib/rasterize.js "
    
    
    output_path = "#{Dir::tmpdir}/#{NumberHelper.get_random_code(5)}.pdf"
    width=params[:width]
    height=params[:height]
    zoom=1
    
    #width = "300"
    #height = "400"
    
    zoom = "1"
    command = "phantomjs-197 --ignore-ssl-errors=yes  #{command_path} #{url} #{output_path} #{width} #{height} #{zoom}"
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
       redirect_to snapshots_path
       
    end
    
  end
end
