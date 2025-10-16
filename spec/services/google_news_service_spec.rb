require 'rails_helper'

RSpec.describe GoogleNewsService do
  describe '.fetch' do
    let(:location) { 'Lisboa' }
    let(:google_news_url) do
      "https://news.google.com/rss/search?q=Turismo+#{location}&hl=pt-BR"
    end
    
    let(:rss_xml_response) do
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

    before do
      stub_request(:get, google_news_url)
        .to_return(
          status: 200,
          body: rss_xml_response,
          headers: { 'Content-Type' => 'application/rss+xml' }
        )
    end

    it 'retorna um array de notícias' do
      result = GoogleNewsService.fetch(location: location)

      expect(result).to be_an(Array)
    end

    it 'cada notícia contém título, descrição, data e link' do
      result = GoogleNewsService.fetch(location: location)

      result.each do |noticia|
        expect(noticia).to have_key(:title)
        expect(noticia).to have_key(:description)
        expect(noticia).to have_key(:pubDate)
        expect(noticia).to have_key(:link)
        
        expect(noticia[:title]).not_to be_empty
        expect(noticia[:description]).not_to be_empty
        expect(noticia[:pubDate]).not_to be_nil
        expect(noticia[:link]).not_to be_empty
        
      end
    end

    it 'parseia corretamente os dados do RSS' do
      result = GoogleNewsService.fetch(location: location)

      # Verifica a primeira notícia especificamente
      primeira_noticia = result.first
      expect(primeira_noticia[:title]).to eq("Melhores pontos turísticos de #{location}")
      expect(primeira_noticia[:description]).to eq('Descubra os melhores lugares para visitar')
      expect(primeira_noticia[:pubDate]).to eq('13/03/2025')
      expect(primeira_noticia[:link]).to eq('https://exemplo.com/noticia-1')
      
    end

    it 'faz requisição para a URL correta do Google News' do
      GoogleNewsService.fetch(location: location)

      # Verifica que a requisição foi feita para a URL esperada
      expect(WebMock).to have_requested(:get, google_news_url).once
    end

    context 'com localização diferente' do
      let(:location) { 'Porto' }

      it 'monta a URL com a localização correta' do
        stub_request(:get, google_news_url)
          .to_return(status: 200, body: rss_xml_response)

        GoogleNewsService.fetch(location: location)

        expect(WebMock).to have_requested(:get, google_news_url).once
      end
    end
  end
end