// 脚注とフッター
// ヘッダー

// 色設定
#let dark = true
#let colorset = if dark {
  (
  text: rgb("ADBAC7"),
  inverse_text: rgb("404040"),
  background: rgb("22272e"),
  caution: rgb("6CB6FF"),
  cautionpale: rgb("353747"),
  alert: rgb("F47067"),
  alertpale: rgb("7a594e")
  )
} else {
  (
  text: rgb("#404040"),
  inverse_text: rgb("fafafa"),
  background: rgb("fafafa"),
  caution: rgb("005CC5"),
  cautionpale: rgb("a6c7ed"),
  alert: rgb("D73A49"),
  alertpale: rgb("f0c7cb")
  )
}

#let conf(
  title: none,
  author: (),
  abstract: [],
  titlesize: 17pt, //タイトルのフォントサイズ
  authorsize: 12pt, //著者名のフォントサイズ
  textsize: 13.5pt, // 本文フォントサイズ
  abstract_title_size: 17pt, //アブストタイトルのサイズ
  abstract_text_size: 10pt, //アブスト本文サイズ
  dark: false, // ダークモード設定
  doc,
) = {
  // ページ設定
  set page(
    width: 390pt,
    height: 590pt,
    margin: (x: 1.0cm, y: 1.0cm),
    number-align: center,
    fill: colorset.at("background")
  )
  // パラグラフデフォルト設定
  set par(
    leading: 0.8em, //行送り
    first-line-indent: 1em, //一行目インデント
    justify: true,
  )
  // 見出し
  show heading: it => {
    set align(left)
    let fontsize = if it.level == 1 {
      textsize * 1.1
    } else {
      textsize * 1.1
    }
    set text(fontsize, weight: "regular")
    counter("heading").step(level: it.level)
    block(strong(
      counter("heading").display() + " " + it.body
    ))
  }
  
  //本文のフォントと色
  set text(
    font: "UD Digi Kyokasho NP-R",
  //  font: "Noto Sans JP",
    lang: "ja",
    size: textsize,
    fill: colorset.at("text")
  )
  // 強調表示
  show strong: set text(font: "IBM Plex Sans JP Smbld")
  //show strong: set text(font: "Noto Sans JP Mdm")
  // 箇条書きと別行立て数式の設定
  set list(indent: 1em)
  set enum(
    indent: 1em,
    numbering: "(1)"
  )
  set math.equation(numbering: "(1)")

  align(center, text(titlesize)[
    *#title*
  ])
  align(center, text(authorsize)[
    #author
  ])

  par(justify: false)[
    //#v(16pt)
    #align(center, text(abstract_title_size)[*Abstract*]) \
    #v(-30pt)
    #align(center, text(abstract_text_size)[
      #abstract
    ])
  ]

  v(8pt)
  columns(1, doc)
}


// theorem 用カウンタの定義
#let theorem-number = counter("theorem-number")

// theorem 関数の定義。コマンドみたいに使える
#let theorem(title: none, kind: "定理", body) = {
  let title-text = {
    if title == none {
      emph[#kind 2.#theorem-number.display()]
    } else {
      emph[#kind 2.#theorem-number.display() 【#title】]
    }
  }
  box(stroke: (left: 1pt), inset: (left: 5pt, top: 2pt, bottom: 5pt))[
    #title-text #h(0.5em)
    #body
  ]
  theorem-number.step()
}

#let dualblock(
  densecolor: none,
  palecolor: none,
  upper_text_color: none,
  lower_text_color: none,
  upper_text: [],
  lower_text: [],
) = {
  set align(center)
  block(
    width: 390pt - 2.0cm,
    fill: densecolor,
    inset: 4pt,
    below: 0pt
  )[
    #align(
      left, 
      text(fill: upper_text_color)[#upper_text]
    )
  ]
  block(
    width: 390pt - 2.0cm,
    fill: palecolor,
    inset: 8pt,
    above: 0pt
  )[#text(fill: lower_text_color)[#lower_text]]
}

#let note_num = counter("note_num")
#let note(
  title: none, 
  content: []
) = {
  note_num.step()
  dualblock(
    densecolor: colorset.at("caution"),
    palecolor: colorset.at("cautionpale"),
    upper_text_color: colorset.at("inverse_text"),
    lower_text_color: colorset.at("text"),
    upper_text: strong([Note #note_num.display() 【#title】]),
    lower_text: content
  )
}

#let imp_num = counter("imp_num")
#let imp(
  title: none, 
  content: []
) = {
  imp_num.step()
  dualblock(
    densecolor: colorset.at("alert"),
    palecolor: colorset.at("alertpale"),
    upper_text_color: colorset.at("inverse_text"),
    lower_text_color: colorset.at("text"),
    upper_text: strong([重要 #imp_num.display() 【#title】]),
    lower_text: content
  )
}



#show: doc => conf(
  title: [
    *日本国憲法前文*
  ],
  author: [
    吉田敦司 \
    研究第一部 材料グループ
  ],
  abstract: lorem(80),
  dark: true,
  doc
)

= *緒言*
#strong("日本国民")は正当に選挙された国会における代表者を通じて行動し、われらとわれらの子孫のために、諸国民と協和による成果と、わが国全土にわたって自由のもたらす恵沢を確保し、政府の行為によって再び戦争の惨禍が起こることのないようにすることを決意し、ここに主権が国民に存することを宣言し、この憲法を確定する#cite("electronic")。
#note(title: "テスト", content: "そもそも国政は国民の厳粛な信託によるものであって、その権威は国民に由来し、その権力は国民の代表者がこれを行使し、その福利は国民がこれを享受する。これは人類普遍の原理であり、この憲法は、かかる原理に基づくものである。われらはこれに反する一切の憲法、法令及び詔勅を排除する。")


== test
日本国民は、恒久の平和を念願し、人間相互の関係を支配する崇高な理想を深く自覚するのであって、平和を愛する諸国民の公正と信義を信頼して、われらの安全と生存を保持しようと決意した。われらは平和を維持し、専制と隷従、圧迫と偏狭を地上から永遠に除去しようと努めている国際社会において、名誉ある地位を占めたいと思う。われらは全世界の国民が、ひとしく恐怖と欠乏から免れ、平和の内に生存する権利を有することを確認する。

われらは、いずれの国家も、自国のことのみに専念して他国を無視してはならないのであって、政治道徳の法則は、普遍的なものであり、この法則に従うことは、自国の主権を維持し、他国と対等関係に立とうとする各国の責務であると信ずる。

日本国民は、国家の名誉にかけて、全力をあげて崇高な理想と目的を達成することを誓う。 

#strong("日本国民")は正当に選挙された国会における代表者を通じて行動し、われらとわれらの子孫のために、諸国民と協和による成果と、わが国全土にわたって自由のもたらす恵沢を確保し、政府の行為によって再び戦争の惨禍が起こることのないようにすることを決意し、ここに主権が国民に存することを宣言し、この憲法を確定する。そもそも国政は国民の厳粛な信託によるものであって、その権威は国民に由来し、その権力は国民の代表者がこれを行使し、その福利は国民がこれを享受する。これは人類普遍の原理であり、この憲法は、かかる原理に基づくものである。われらはこれに反する一切の憲法、法令及び詔勅を排除する。

日本国民は、恒久の平和を念願し、人間相互の関係を支配する崇高な理想を深く自覚するのであって、平和を愛する諸国民の公正と信義を信頼して、われらの安全と生存を保持しようと決意した。われらは平和を維持し、専制と隷従、圧迫と偏狭を地上から永遠に除去しようと努めている国際社会において、名誉ある地位を占めたいと思う。われらは全世界の国民が、ひとしく恐怖と欠乏から免れ、平和の内に生存する権利を有することを確認する。

われらは、いずれの国家も、自国のことのみに専念して他国を無視してはならないのであって、政治道徳の法則は、普遍的なものであり、この法則に従うことは、自国の主権を維持し、他国と対等関係に立とうとする各国の責務であると信ずる。

日本国民は、国家の名誉にかけて、全力をあげて崇高な理想と目的を達成することを誓う。

#strong("日本国民")は正当に選挙された国会における代表者を通じて行動し、われらとわれらの子孫のために、諸国民と協和による成果と、わが国全土にわたって自由のもたらす恵沢を確保し、政府の行為によって再び戦争の惨禍が起こることのないようにすることを決意し、ここに主権が国民に存することを宣言し、この憲法を確定する。そもそも国政は国民の厳粛な信託によるものであって、その権威は国民に由来し、その権力は国民の代表者がこれを行使し、その福利は国民がこれを享受する。これは人類普遍の原理であり、この憲法は、かかる原理に基づくものである。われらはこれに反する一切の憲法、法令及び詔勅を排除する。

日本国民は、恒久の平和を念願し、人間相互の関係を支配する崇高な理想を深く自覚するのであって、平和を愛する諸国民の公正と信義を信頼して、われらの安全と生存を保持しようと決意した。われらは平和を維持し、専制と隷従、圧迫と偏狭を地上から永遠に除去しようと努めている国際社会において、名誉ある地位を占めたいと思う。われらは全世界の国民が、ひとしく恐怖と欠乏から免れ、平和の内に生存する権利を有することを確認する。

われらは、いずれの国家も、自国のことのみに専念して他国を無視してはならないのであって、政治道徳の法則は、普遍的なものであり、この法則に従うことは、自国の主権を維持し、他国と対等関係に立とうとする各国の責務であると信ずる。

日本国民は、国家の名誉にかけて、全力をあげて崇高な理想と目的を達成することを誓う。

#strong("日本国民")は正当に選挙された国会における代表者を通じて行動し、われらとわれらの子孫のために、諸国民と協和による成果と、わが国全土にわたって自由のもたらす恵沢を確保し、政府の行為によって再び戦争の惨禍が起こることのないようにすることを決意し、ここに主権が国民に存することを宣言し、この憲法を確定する。そもそも国政は国民の厳粛な信託によるものであって、その権威は国民に由来し、その権力は国民の代表者がこれを行使し、その福利は国民がこれを享受する。これは人類普遍の原理であり、この憲法は、かかる原理に基づくものである。われらはこれに反する一切の憲法、法令及び詔勅を排除する。

日本国民は、恒久の平和を念願し、人間相互の関係を支配する崇高な理想を深く自覚するのであって、平和を愛する諸国民の公正と信義を信頼して、われらの安全と生存を保持しようと決意した。われらは平和を維持し、専制と隷従、圧迫と偏狭を地上から永遠に除去しようと努めている国際社会において、名誉ある地位を占めたいと思う。われらは全世界の国民が、ひとしく恐怖と欠乏から免れ、平和の内に生存する権利を有することを確認する。

われらは、いずれの国家も、自国のことのみに専念して他国を無視してはならないのであって、政治道徳の法則は、普遍的なものであり、この法則に従うことは、自国の主権を維持し、他国と対等関係に立とうとする各国の責務であると信ずる。

日本国民は、国家の名誉にかけて、全力をあげて崇高な理想と目的を達成することを誓う。

#bibliography("works.yml")
