require 'pp'
require_relative './morph'
include Morph

class Markov3
  def initialize
    Morph::init_analyzer
    @dic = {}
    @starts = []
  end

  # recieve sentences as array([s1, s2, ...]), and make sentence
  def generate(sentences)
    # analyze
    analyze(sentences)

    # make sentence
    response = generate_sentence
  end

  # analyze sentences
  def analyze(sentences)
    sentences.each do |sentence|
      # morphological analysis
      analyzed_sentence = Morph::analyze(sentence)

      # save analyzed sentences
      save_sencence(analyzed_sentence)
    end
  end

  # save analyzed sentence to @dic !!!!!
  # prefix1-1 => {
  #                prefix2-1 => {
  #                               prefix3-1,
  #                               prefix3-2, ...
  #                             },
  #                prefix2-2 => {
  #                               prefix3-1,
  #                               prefix3-2, ...
  #                             }, ...
  #              },
  # prefix1-2 => { ... }
  #
  def save_sencence(analyzed_sentence)
    prefix1, prefix2, prefix3 = analyzed_sentence.shift[0], analyzed_sentence.shift[0], analyzed_sentence.shift[0]

    # save start word to @starts 
    @starts << prefix1

    analyzed_sentence.each do |info|
      add_suffix(prefix1, prefix2, prefix3, info[0])
      prefix1 = prefix2
      prefix2 = prefix3
      prefix3 = info[0]
    end
  end


  # @dic{ prefix1 }
  def add_suffix(prefix1, prefix2, prefix3, suffix)
    @dic[prefix1] = {} unless @dic[prefix1]

  end

  def generate_sentence
    p @starts
    pp @dic
  end
end

markov = Markov3.new
arr = [
  'ひどい主催をしてしまったが真祖型紙は手に入れた',
  'ぬう流石に黒曜は最大5か',
#  '3つ目は実際ある',
#  'DTMerは音楽と付き合いたい結婚したいっていう奴らの集まりだから基本変態。',
#  'にゃにゃにゃにゃにゃんこ',
#  '∬きいてなう∬　【title:2 hundred over 【インスト】】 upload by @m_mikanagi #tmbox_806247 http://tmbox.net/pl/806247 　こんばんエーリカ！'
]

markov.generate(arr)
