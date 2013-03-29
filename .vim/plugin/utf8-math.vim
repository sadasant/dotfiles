" From http://www.vim.org/scripts/download_script.php?src_id=10264
" But changed everything to be preceded by \, I CODE DUDES... xD
" More symbols here: http://ia.wikipedia.org/wiki/Wikipedia:LaTeX_symbols

setlocal fileencoding=utf-8
setlocal bomb
"setlocal formatprg=par\ 60l
"setlocal ai et ts=3 sw=3 sta
"setlocal tw=60


" Some nice text formatting first
imap \' ’
imap \` ‘
imap \`` “
imap \'' ”
imap \-- –
imap \--- — 
imap \... …
imap \<< «
imap \>> »

" arrows
imap \--> →
imap \<-- ←
imap \<--> ↔
imap \==> ⇒
imap \<== ⇐
imap \<==> ⇔
imap \up ↑
imap \down ↓

" Superscripts
imap \^0 ⁰
imap \^1 ¹
imap \^2 ²
imap \^3 ³
imap \^4 ⁴
imap \^5 ⁵
imap \^6 ⁶
imap \^7 ⁷
imap \^8 ⁸
imap \^9 ⁹
imap \^+ ⁺
imap \^- ⁻
imap \^= ⁼
imap \^( ⁽
imap \^) ⁾
imap \^n ⁿ

" Subscripts
imap \_0 ₀
imap \_1 ₁
imap \_2 ₂
imap \_3 ₃
imap \_4 ₄
imap \_5 ₅
imap \_6 ₆
imap \_7 ₇
imap \_8 ₈
imap \_9 ₉
imap \_+ ₊
imap \_- ₋
imap \_= ₌
imap \_( ₍
imap \_) ₎

" relational algebra
imap \join ⋈

" Mathematical symbols, LaTeX style
imap \forall ∀
imap \exists ∃
imap \empty ∅
imap \prod ∏
imap \sum ∑
imap \pm ±
imap \setminus ∖
imap \int ∫
imap \therefore ∴
imap \qed ∎
imap \1 𝟙
imap \N ℕ
imap \Z ℤ
imap \C ℂ
imap \Q ℚ
imap \R ℝ
imap \E 𝔼
imap \F 𝔽
imap \to →
imap \mapsto ↦
imap \infty ∞
imap \cong ≅
imap \:= ≔
imap \=: ≕
imap \ne ≠
imap \approx ≈
imap \perp ⊥
imap \not ̷
imap \ldots …
imap \cdots ⋯
imap \cdot ⋅
imap \circ ∘
imap \times ×
imap \oplus ⊕
imap \langle ⟨
imap \rangle ⟩

" Math order
imap \leq ≤
imap \geq ≥
imap \leqq ≦
imap \geqq ≧
imap \lneqq ≨
imap \gneqq ≩
imap \vartriangleleft ⊲
imap \vartriangleright ⊳
imap \trianglelefteq ⊴
imap \trianglerighteq ⊵
imap \lesssim ≲
imap \gtrsim ≳
imap \prec ≺
imap \succ ≻
imap \preceq ≼
imap \succeq ≽
imap \precsim ≾
imap \succsim ≿
imap \ntriangleleft ⋪
imap \ntriangleright ⋫
imap \lnsim ⋦
imap \gnsim ⋧
imap \precnsim ⋨
imap \succnsim ⋩
imap \curlyeqprec ⋞
imap \curlyeqsucc ⋟

" Set symbols
imap \subset ⊂
imap \subseteq ⊆
imap \nsubseteq ⊈
imap \supset ⊃
imap \supseteq ⊇
imap \nsupseteq ⊉
imap \cap ∩
imap \cup ∪
imap \in ∈
imap \ni ∋
imap \notin ∉

" Equality and Inference
imap \vdash ⊦
imap \vDash ⊨

" Other symbols
imap \top ⊤
imap \bot ⊥

" Greek letters...
imap \alpha α
imap \beta β
imap \gamma γ
imap \delta δ
imap \epsilon ε
imap \zeta ζ
imap \eta η
imap \theta θ
imap \iota ι
imap \kappa κ
imap \lambda λ
imap \mu μ
imap \nu ν
imap \xi ξ
imap \omicron ο
imap \pi π
imap \rho ρ
imap \stigma ς
imap \sigma σ
imap \tau τ
imap \upsilon υ
imap \phi ϕ
imap \varphi φ
imap \chi χ
imap \psi ψ
imap \omega ω

imap \Alpha Α
imap \Beta Β
imap \Gamma Γ
imap \Delta Δ
imap \Epsilon Ε
imap \Zeta Ζ
imap \Eta Η
imap \Theta Θ
imap \Iota Ι
imap \Kappa Κ
imap \Lambda Λ
imap \Mu Μ
imap \Nu Ν
imap \Xi Ξ
imap \Omicron Ο
imap \Pi Π
imap \Rho Ρ
imap \Sigma Σ
imap \Tau Τ
imap \Upsilon Υ
imap \Phi Φ
imap \Chi Χ
imap \Psi Ψ
imap \Omega Ω





