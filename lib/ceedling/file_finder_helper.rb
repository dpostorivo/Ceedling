require 'fileutils'
require 'ceedling/constants' # for Verbosity enumeration

class FileFinderHelper

  constructor :streaminator
  
  
  def find_file_in_collection(file_name, file_list, complain, extra_message="")
    file_to_find = nil
  
    pp ''
    pp file_list
    file_list.each do |item|
      base_file = item

      if (base_file.end_with?(file_name))
        # case sensitive check
        puts base_file
        puts file_name
        if (File.basename(base_file) == File.basename(file_name))
          file_to_find = item
          break
        else
          blow_up(file_name, "However, a filename having different capitalization was found: '#{item}'.")
        end
      end
      
    end
    
    case (complain)
      when :error then blow_up(file_name, extra_message) if (file_to_find.nil?)
      when :warn  then gripe(file_name, extra_message)   if (file_to_find.nil?)
      #when :ignore then      
    end
    
    return file_to_find
  end

  private
  
  def blow_up(file_name, extra_message="")
    error = "ERROR: Found no file '#{file_name}' in search paths."
    error += ' ' if (extra_message.length > 0)
    @streaminator.stderr_puts(error + extra_message, Verbosity::ERRORS)
    raise
  end
  
  def gripe(file_name, extra_message="")
    warning = "WARNING: Found no file '#{file_name}' in search paths."
    warning += ' ' if (extra_message.length > 0)
    @streaminator.stderr_puts(warning + extra_message, Verbosity::COMPLAIN)
  end

end


