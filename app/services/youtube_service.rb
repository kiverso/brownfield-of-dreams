class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }

    get_json('youtube/v3/videos', params)
  end

  def import_playlist_items(id)
    params = { part: 'snippet', playlistId: id, maxResults: 50 }

    get_json('youtube/v3/playlistItems', params)
  end

  def import_playlist(id)
    params = { part: 'snippet', maxResults: 50, id: id }

    parsed = get_json('youtube/v3/playlists', params)
    parser = parsed[:items][0][:snippet]
  end
  private

  def get_json(url, params)
    response = conn.get(url, params)

    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://www.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['YOUTUBE_API_KEY']
    end
  end
end
