def google_news_rss_xml(location)
  <<~XML
    <?xml version="1.0" encoding="UTF-8"?>
    <rss version="2.0">
      <channel>
        <generator>NFE/5.0</generator>&hl=pt
        <title>"Turismo #{location}" - Google Notícias</title>
        <link>
          https://news.google.com/search?q=Turismo+#{location}&hl=pt-BR&gl=BR&ceid=BR:pt-419
        </link>
        <webMaster>news-webmaster@google.com</webMaster>
        <copyright>
          Copyright © 2025 Google. All rights reserved. This XML feed is made available solely for the purpose of rendering Google News results within a personal feed reader for personal, non-commercial use. Any other use of the feed is expressly prohibited. By accessing this feed or using these results in any manner whatsoever, you agree to be bound by the foregoing restrictions.
        </copyright>
        <lastBuildDate>Sun, 12 Oct 2025 17:16:39 GMT</lastBuildDate>
        <image>
        <title>Google Notícias</title>
        <url>
          https://lh3.googleusercontent.com/-DR60l-K8vnyi99NZovm9HlXyZwQ85GMDxiwJWzoasZYCUrPuUM_P_4Rb7ei03j-0nRs0c4F=w256
        </url>
        <link>https://news.google.com/</link>
        <height>256</height>
        <width>256</width>
        </image>
        <description>Google Notícias</description>
        <item>
          <title>Melhores pontos turísticos de #{location}</title>
          <link>https://exemplo.com/noticia-1</link>
          <guid isPermaLink="false">
            CBMigAJBVV95cUxPdzlvNzRmRTg0ZUhCR2EyX0hNRzQ1WHdsVGdtZGpOUXVLemtDeE5JcHZCUEdKVF9VY29EN21iXzdMcGpFWjd2RDlqaXlqWG5XaTRDWWY2SDdQdkF3MkIwREVKRkFDUmc1Tl9qQWhFWmZTSUtkb1Y3alhNV1J4cFV0ekl0aHJkOHNYYzNrTHo4aFIzQl9STEVfdUN2RVc4ZkVjYUtrMUpPZmY4Q1Z2X3k4c3ZKNUNVZU1aaGo3TmRkeGVGX0tMUU4yWjVBVHI0bXp0QmpPYy1VcVZLejl2eE15NzhZVk5lU1l2SmdVeGxVa2ZBVEZmRzN0WWdZZ0ZpcXZR
          </guid>
          <pubDate>Thu, 13 Mar 2025 07:00:00 GMT</pubDate>
          <description>Descubra os melhores lugares para visitar</description>
          <source url="https://www.to.gov.br">to.gov.br</source>
        </item>
        <item>
          <title>Guia de viagem: #{location}</title>
          <link>https://exemplo.com/noticia-2</link>
          <guid isPermaLink="false">
            CBMigAJBVV95cUxPdzlvNzRmRTg0ZUhCR2EyX0hNRzQ1WHdsVGdtZGpOUXVLemtDeE5JcHZCUEdKVF9VY29EN21iXzdMcGpFWjd2RDlqaXlqWG5XaTRDWWY2SDdQdkF3MkIwREVKRkFDUmc1Tl9qQWhFWmZTSUtkb1Y3alhNV1J4cFV0ekl0aHJkOHNYYzNrTHo4aFIzQl9STEVfdUN2RVc4ZkVjYUtrMUpPZmY4Q1Z2X3k4c3ZKNUNVZU1aaGo3TmRkeGVGX0tMUU4yWjVBVHI0bXp0QmpPYy1VcVZLejl2eE15NzhZVk5lU1l2SmdVeGxVa2ZBVEZmRzN0WWdZZ0ZpcXZR
          </guid>
          <pubDate>Mon, 07 Apr 2025 07:00:00 GMT</pubDate>
          <description>Um guia completo para sua viagem</description>
          <source url="https://www.to.gov.br">to.gov.br</source>
        </item>
        <item>
          <title>Turismo em #{location} cresce 20%</title>
          <link>https://exemplo.com/noticia-3</link>
          <guid isPermaLink="false">
            CBMigAJBVV95cUxPdzlvNzRmRTg0ZUhCR2EyX0hNRzQ1WHdsVGdtZGpOUXVLemtDeE5JcHZCUEdKVF9VY29EN21iXzdMcGpFWjd2RDlqaXlqWG5XaTRDWWY2SDdQdkF3MkIwREVKRkFDUmc1Tl9qQWhFWmZTSUtkb1Y3alhNV1J4cFV0ekl0aHJkOHNYYzNrTHo4aFIzQl9STEVfdUN2RVc4ZkVjYUtrMUpPZmY4Q1Z2X3k4c3ZKNUNVZU1aaGo3TmRkeGVGX0tMUU4yWjVBVHI0bXp0QmpPYy1VcVZLejl2eE15NzhZVk5lU1l2SmdVeGxVa2ZBVEZmRzN0WWdZZ0ZpcXZR
          </guid>
          <pubDate>Thu, 13 Mar 2025 07:00:00 GMT</pubDate>
          <description>Setor turístico em expansão</description>
          <source url="https://www.to.gov.br">to.gov.br</source>
        </item>
      </channel>
    </rss>
  XML
end

def stub_google_news_rss(location)
  url = "https://news.google.com/rss/search?q=Turismo+#{location}&hl=pt-BR"

  stub_request(:get, url)
    .to_return(
      status: 200,
      body: google_news_rss_xml(location),
      headers: { 'Content-Type' => 'application/rss+xml'}
    )
end

Quando('eu busco notícias de turismo para {string}') do |location|
  # XML response location 
  stub_google_news_rss(location)

  visit news_path(location: location)
end

Então('eu devo ver uma lista com notícias') do
  expect(page).to have_selector('.noticia')
end

Então('cada notícia deve ter um título') do
  noticias = page.all('.noticia')
  expect(noticias).not_to be_empty

  noticias.each do |noticia|
    expect(noticia).to have_selector('.noticia-titulo')
    expect(noticia.find('.noticia-titulo').text).not_to be_empty
  end
end

Então('cada notícia deve ter um link') do
  noticias = page.all('.noticia')
  expect(noticias).not_to be_empty

  noticias.each do |noticia|
    expect(noticia).to have_selector('a.noticia-link')
    expect(noticia.find('a.noticia-link')[:href]).not_to be_empty
  end
end

Então('cada notícia deve ter uma descrição') do
  noticias = page.all('.noticia')
  expect(noticias).not_to be_empty

  noticias.each do |noticia|
    expect(noticia).to have_selector('.noticia-descricao')
    expect(noticia.find('.noticia-descricao').text).not_to be_empty
  end
end

Então('cada notícia deve ter uma data') do
  noticias = page.all('.noticia')
  expect(noticias).not_to be_empty

  noticias.each do |noticia|
    expect(noticia).to have_selector('.noticia-data')
    expect(noticia.find('.noticia-data').text).not_to be_empty
  end
end