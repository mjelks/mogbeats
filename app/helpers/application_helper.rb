module ApplicationHelper
  def mog_id_cleanup(mog_id)
    return mog_id.to_s.gsub(/.*?\/?(\d+)/,'\1')
  end
end
