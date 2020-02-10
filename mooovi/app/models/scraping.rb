class Scraping
  def self.movie_urls
      links    = []
      agent    = Mechanize.new
      next_url = ""

      while true
        current_page = agent.get("http://review-movie.herokuapp.com/" + next_url)

        current_page.search(".entry-title a").each do |element|
          links << element[:href]
        end

        next_link = current_page.at('.pagination .next a')

        # next_linkがなかったらwhile文を抜ける
        break unless next_link

        # そのタグからhref属性の値を取得
        next_url = next_link[:href]
      end

      links.each do |link|
        get_product("http://review-movie.herokuapp.com" + link)
      end
    end

  def self.get_product(link)
    agent     = Mechanize.new
    page      = agent.get(link)
    title     = page.at(".entry-title").inner_text
    image_url = page.at(".entry-content img")[:src]    if page.at(".entry-content img")
    director  = page.at(".director span").inner_text   if page.at(".director span")
    detail    = page.at(".entry-content p").inner_text if page.at(".entry-content p")
    open_date = page.at(".date span").inner_text       if page.at(".date span")

    product = Product.where(title: title).first_or_initialize
    product.image_url = image_url
    product.director  = director
    product.detail    = detail
    product.open_date = open_date
    product.save
  end
end