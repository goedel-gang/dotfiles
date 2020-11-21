" vim: fdm=marker fdl=0

" Tell vim how to handle comments in Lean

setlocal commentstring=--%s
setlocal comments+=:--

" Add the standard Lean abbreviations

" I have omitted all abbreviations not consisting solely of alphabet characters
" for technical reasons.

" TODO: move into separate file
" mappings: {{{
let b:lean_mappings = {
    \ "a": "α",
    \ "b": "β",
    \ "c": "χ",
    \ "d": "↓",
    \ "e": "ε",
    \ "g": "γ",
    \ "i": "∩",
    \ "m": "μ",
    \ "n": "¬",
    \ "o": "∘",
    \ "p": "Π",
    \ "t": "▸",
    \ "r": "→",
    \ "u": "↑",
    \ "v": "∨",
    \ "x": "×",
    \ "l": "←",
    \ "O": "Ø",
    \ "A": "𝔸",
    \ "C": "ℂ",
    \ "D": "Δ",
    \ "F": "𝔽",
    \ "G": "Γ",
    \ "H": "ℍ",
    \ "I": "⋂",
    \ "K": "𝕂",
    \ "L": "Λ",
    \ "N": "ℕ",
    \ "P": "Π",
    \ "Q": "ℚ",
    \ "R": "ℝ",
    \ "S": "Σ",
    \ "U": "⋃",
    \ "Z": "ℤ",
    \ "be": "β",
    \ "ga": "γ",
    \ "de": "δ",
    \ "ep": "ε",
    \ "ze": "ζ",
    \ "et": "η",
    \ "th": "θ",
    \ "io": "ι",
    \ "ka": "κ",
    \ "la": "λ",
    \ "mu": "μ",
    \ "nu": "ν",
    \ "xi": "ξ",
    \ "pi": "π",
    \ "rh": "ρ",
    \ "vsi": "ς",
    \ "si": "σ",
    \ "ta": "τ",
    \ "ph": "φ",
    \ "ch": "χ",
    \ "ps": "ψ",
    \ "om": "ω",
    \ "notin": "∉",
    \ "note": "♩",
    \ "not": "¬",
    \ "nomisma": "𐆎",
    \ "nin": "∌",
    \ "ni": "∋",
    \ "nattrans": "⟹",
    \ "natural": "♮",
    \ "nat": "ℕ",
    \ "naira": "₦",
    \ "nabla": "∇",
    \ "napprox": "≉",
    \ "numero": "№",
    \ "nLeftarrow": "⇍",
    \ "nLeftrightarrow": "⇎",
    \ "nRightarrow": "⇏",
    \ "nVDash": "⊯",
    \ "nVdash": "⊮",
    \ "ncong": "≇",
    \ "nearrow": "↗",
    \ "neg": "¬",
    \ "nequiv": "≢",
    \ "neq": "≠",
    \ "nexists": "∄",
    \ "ne": "≠",
    \ "ngeqq": "≱",
    \ "ngeqslant": "≱",
    \ "ngeq": "≱",
    \ "ngtr": "≯",
    \ "nleftarrow": "↚",
    \ "nleftrightarrow": "↮",
    \ "nleqq": "≰",
    \ "nleqslant": "≰",
    \ "nleq": "≰",
    \ "nless": "≮",
    \ "nmid": "∤",
    \ "nparallel": "∦",
    \ "npreceq": "⋠",
    \ "nprec": "⊀",
    \ "nrightarrow": "↛",
    \ "nshortmid": "∤",
    \ "nshortparallel": "∦",
    \ "nsimeq": "≄",
    \ "nsim": "≁",
    \ "nsubseteqq": "⊈",
    \ "nsubseteq": "⊈",
    \ "nsubset": "⊄",
    \ "nsucceq": "⋡",
    \ "nsucc": "⊁",
    \ "nsupseteqq": "⊉",
    \ "nsupseteq": "⊉",
    \ "nsupset": "⊅",
    \ "ntrianglelefteq": "⋬",
    \ "ntriangleleft": "⋪",
    \ "ntrianglerighteq": "⋭",
    \ "ntriangleright": "⋫",
    \ "nvDash": "⊭",
    \ "nvdash": "⊬",
    \ "nwarrow": "↖",
    \ "eqn": "≠",
    \ "equiv": "≃",
    \ "eqcirc": "≖",
    \ "eqcolon": "≕",
    \ "eqslantgtr": "⋝",
    \ "eqslantless": "⋜",
    \ "entails": "⊢",
    \ "en": "–",
    \ "exn": "∄",
    \ "exists": "∃",
    \ "ex": "∃",
    \ "emptyset": "∅",
    \ "empty": "∅",
    \ "em": "—",
    \ "epsilon": "ε",
    \ "eps": "ε",
    \ "euro": "€",
    \ "eta": "η",
    \ "ell": "ℓ",
    \ "iso": "≅",
    \ "inn": "∉",
    \ "intersection": "∩",
    \ "intercal": "⊺",
    \ "integral": "∫",
    \ "int": "ℤ",
    \ "inv": "⁻¹",
    \ "increment": "∆",
    \ "infty": "∞",
    \ "inf": "∞",
    \ "in": "∈",
    \ "iff": "↔",
    \ "imp": "→",
    \ "imath": "ı",
    \ "iota": "ι",
    \ "homotopy": "∼",
    \ "hom": "⟶",
    \ "hori": "ϩ",
    \ "hookleftarrow": "↩",
    \ "hookrightarrow": "↪",
    \ "hryvnia": "₴",
    \ "heta": "ͱ",
    \ "heartsuit": "♥",
    \ "hbar": "ℏ",
    \ "and": "∧",
    \ "an": "∧",
    \ "angle": "∟",
    \ "angstrom": "Å",
    \ "all": "∀",
    \ "allf": "∀ᶠ",
    \ "allm": "∀ₘ",
    \ "alpha": "α",
    \ "aleph": "ℵ",
    \ "asterisk": "⁎",
    \ "ast": "∗",
    \ "asymp": "≍",
    \ "apl": "⌶",
    \ "approxeq": "≊",
    \ "approx": "≈",
    \ "aa": "å",
    \ "ae": "æ",
    \ "austral": "₳",
    \ "afghani": "؋",
    \ "amalg": "∐",
    \ "ordfeminine": "ª",
    \ "ordmasculine": "º",
    \ "or": "∨",
    \ "oplus": "⊕",
    \ "op": "ᵒᵖ",
    \ "ox": "⊗",
    \ "oo": "⊚",
    \ "oe": "œ",
    \ "octagonal": "🛑",
    \ "ohm": "Ω",
    \ "ounce": "℥",
    \ "omega": "ω",
    \ "omicron": "ο",
    \ "ominus": "⊖",
    \ "odot": "⊙",
    \ "oint": "∮",
    \ "oslash": "⊘",
    \ "otimes": "⊗",
    \ "transport": "▹",
    \ "trans": "▹",
    \ "triangledown": "▿",
    \ "trianglelefteq": "⊴",
    \ "triangleleft": "◃",
    \ "triangleq": "≜",
    \ "trianglerighteq": "⊵",
    \ "triangleright": "▹",
    \ "triangle": "▵",
    \ "tr": "⬝",
    \ "tb": "◂",
    \ "twoheadleftarrow": "↞",
    \ "twoheadrightarrow": "↠",
    \ "tw": "◃",
    \ "tie": "⁀",
    \ "times": "×",
    \ "theta": "θ",
    \ "therefore": "∴",
    \ "thickapprox": "≈",
    \ "thicksim": "∼",
    \ "telephone": "℡",
    \ "tenge": "₸",
    \ "textmusicalnote": "♪",
    \ "textmu": "µ",
    \ "textfractionsolidus": "⁄",
    \ "textbaht": "฿",
    \ "textdied": "✝",
    \ "textdiscount": "⁒",
    \ "textcolonmonetary": "₡",
    \ "textcircledP": "℗",
    \ "textwon": "₩",
    \ "textnaira": "₦",
    \ "textnumero": "№",
    \ "textpeso": "₱",
    \ "textpertenthousand": "‱",
    \ "textlira": "₤",
    \ "textlquill": "⁅",
    \ "textrecipe": "℞",
    \ "textreferencemark": "※",
    \ "textrquill": "⁆",
    \ "textinterrobang": "‽",
    \ "textestimated": "℮",
    \ "textopenbullet": "◦",
    \ "tugrik": "₮",
    \ "tau": "τ",
    \ "top": "⊤",
    \ "to": "→",
    \ "finsupp": "→₀",
    \ "toa": "→ₐ",
    \ "ra": "→ₐ",
    \ "alghom": "→ₐ",
    \ "tob": "→ᵇ",
    \ "rb": "→ᵇ",
    \ "boundedcontinuousfunction": "→ᵇ",
    \ "tol": "→ₗ",
    \ "rl": "→ₗ",
    \ "linearmap": "→ₗ",
    \ "tom": "→ₘ",
    \ "rm": "→ₘ",
    \ "aeeqfun": "→ₘ",
    \ "rp": "→ₚ",
    \ "dfinsupp": "→ₚ",
    \ "tos": "→ₛ",
    \ "rs": "→ₛ",
    \ "simplefunc": "→ₛ",
    \ "defs": "≙",
    \ "degree": "°",
    \ "dei": "ϯ",
    \ "delta": "δ",
    \ "doteqdot": "≑",
    \ "doteq": "≐",
    \ "dotplus": "∔",
    \ "dotsquare": "⊡",
    \ "dot": "⬝",
    \ "dong": "₫",
    \ "downarrow": "↓",
    \ "downdownarrows": "⇊",
    \ "downleftharpoon": "⇃",
    \ "downrightharpoon": "⇂",
    \ "drachma": "₯",
    \ "dr": "↘",
    \ "dl": "↙",
    \ "ddagger": "‡",
    \ "ddag": "‡",
    \ "ddots": "⋱",
    \ "dz": "↯",
    \ "dib": "◆",
    \ "diw": "◇",
    \ "die": "⚀",
    \ "division": "÷",
    \ "divideontimes": "⋇",
    \ "div": "÷",
    \ "diameter": "⌀",
    \ "diamondsuit": "♢",
    \ "diamond": "⋄",
    \ "digamma": "ϝ",
    \ "di": "◆",
    \ "dagger": "†",
    \ "dag": "†",
    \ "daleth": "ℸ",
    \ "dashv": "⊣",
    \ "dh": "ð",
    \ "member": "∈",
    \ "mem": "∈",
    \ "measuredangle": "∡",
    \ "male": "♂",
    \ "maltese": "✠",
    \ "manat": "₼",
    \ "mapsto": "↦",
    \ "minus": "−",
    \ "mill": "₥",
    \ "micro": "µ",
    \ "mid": "∣",
    \ "multiplication": "×",
    \ "multimap": "⊸",
    \ "mho": "℧",
    \ "models": "⊧",
    \ "mp": "∓",
    \ "prohibited": "🛇",
    \ "prod": "∏",
    \ "propto": "∝",
    \ "precapprox": "≾",
    \ "preceq": "≼",
    \ "precnapprox": "⋨",
    \ "precnsim": "⋨",
    \ "precsim": "≾",
    \ "prec": "≺",
    \ "prime": "′",
    \ "pr": "↣",
    \ "powerset": "𝒫",
    \ "pounds": "£",
    \ "pound": "£",
    \ "pab": "▰",
    \ "paw": "▱",
    \ "partnership": "㉐",
    \ "partial": "∂",
    \ "paragraph": "¶",
    \ "parallel": "∥",
    \ "pa": "▰",
    \ "pm": "±",
    \ "perp": "⊥",
    \ "permil": "‰",
    \ "per": "⅌",
    \ "peso": "₱",
    \ "peseta": "₧",
    \ "pilcrow": "¶",
    \ "pitchfork": "⋔",
    \ "psi": "ψ",
    \ "phi": "φ",
    \ "leqn": "≰",
    \ "leqq": "≦",
    \ "leqslant": "≤",
    \ "leq": "≤",
    \ "len": "≰",
    \ "leadsto": "↝",
    \ "leftarrowtail": "↢",
    \ "leftarrow": "←",
    \ "leftharpoondown": "↽",
    \ "leftharpoonup": "↼",
    \ "leftleftarrows": "⇇",
    \ "leftrightarrows": "⇆",
    \ "leftrightarrow": "↔",
    \ "leftrightharpoons": "⇋",
    \ "leftrightsquigarrow": "↭",
    \ "leftthreetimes": "⋋",
    \ "lessapprox": "≲",
    \ "lessdot": "⋖",
    \ "lesseqgtr": "⋚",
    \ "lesseqqgtr": "⋚",
    \ "lessgtr": "≶",
    \ "lesssim": "≲",
    \ "le": "≤",
    \ "lub": "⊔",
    \ "lrcorner": "⌟",
    \ "lr": "↔",
    \ "llcorner": "⌞",
    \ "llbracket": "〚",
    \ "ll": "≪",
    \ "lbag": "⟅",
    \ "lambda": "λ",
    \ "lamda": "λ",
    \ "lam": "λ",
    \ "lari": "₾",
    \ "langle": "⟨",
    \ "lira": "₤",
    \ "lceil": "⌈",
    \ "ldots": "…",
    \ "ldq": "“",
    \ "ldata": "《",
    \ "lfloor": "⌊",
    \ "lhd": "◁",
    \ "lnapprox": "⋦",
    \ "lneqq": "≨",
    \ "lneq": "≨",
    \ "lnsim": "⋦",
    \ "lnot": "¬",
    \ "longleftarrow": "⟵",
    \ "longleftrightarrow": "⟷",
    \ "longrightarrow": "⟶",
    \ "looparrowleft": "↫",
    \ "looparrowright": "↬",
    \ "lozenge": "✧",
    \ "lq": "‘",
    \ "ltimes": "⋉",
    \ "lvertneqq": "≨",
    \ "geqn": "≱",
    \ "geqq": "≧",
    \ "geqslant": "≥",
    \ "geq": "≥",
    \ "gen": "≱",
    \ "gets": "←",
    \ "ge": "≥",
    \ "glb": "⊓",
    \ "glqq": "„",
    \ "glq": "‚",
    \ "guarani": "₲",
    \ "gangia": "ϫ",
    \ "gamma": "γ",
    \ "ggg": "⋙",
    \ "gg": "≫",
    \ "gimel": "ℷ",
    \ "gnapprox": "⋧",
    \ "gneqq": "≩",
    \ "gneq": "≩",
    \ "gnsim": "⋧",
    \ "gtrapprox": "≳",
    \ "gtrdot": "⋗",
    \ "gtreqless": "⋛",
    \ "gtreqqless": "⋛",
    \ "gtrless": "≷",
    \ "gtrsim": "≳",
    \ "gvertneqq": "≩",
    \ "grqq": "“",
    \ "grq": "‘",
    \ "root": "√",
    \ "ssubn": "⊄",
    \ "ssub": "⊂",
    \ "ssupn": "⊅",
    \ "ssup": "⊃",
    \ "ssqub": "⊏",
    \ "ssqup": "⊐",
    \ "ss": "⊆",
    \ "subn": "⊈",
    \ "subseteqq": "⊆",
    \ "subseteq": "⊆",
    \ "subsetneqq": "⊊",
    \ "subsetneq": "⊊",
    \ "subset": "⊂",
    \ "sub": "⊆",
    \ "supn": "⊉",
    \ "supseteqq": "⊇",
    \ "supseteq": "⊇",
    \ "supsetneqq": "⊋",
    \ "supsetneq": "⊋",
    \ "supset": "⊃",
    \ "sup": "⊇",
    \ "surd": "√",
    \ "succapprox": "≿",
    \ "succcurlyeq": "≽",
    \ "succeq": "≽",
    \ "succnapprox": "⋩",
    \ "succnsim": "⋩",
    \ "succsim": "≿",
    \ "succ": "≻",
    \ "sum": "∑",
    \ "squbn": "⋢",
    \ "squb": "⊑",
    \ "squpn": "⋣",
    \ "squp": "⊒",
    \ "square": "□",
    \ "squigarrowright": "⇝",
    \ "sqb": "■",
    \ "sqw": "□",
    \ "sqo": "▢",
    \ "sqcap": "⊓",
    \ "sqcup": "⊔",
    \ "sqrt": "√",
    \ "sqsubseteq": "⊑",
    \ "sqsubset": "⊏",
    \ "sqsupseteq": "⊒",
    \ "sqsupset": "⊐",
    \ "sq": "◾",
    \ "sy": "⁻¹",
    \ "stigma": "ϛ",
    \ "star": "⋆",
    \ "straightphi": "φ",
    \ "st": "⋆",
    \ "spesmilo": "₷",
    \ "spadesuit": "♠",
    \ "sphericalangle": "∢",
    \ "section": "§",
    \ "searrow": "↘",
    \ "setminus": "∖",
    \ "san": "ϻ",
    \ "sampi": "ϡ",
    \ "shortmid": "∣",
    \ "shortparallel": "∥",
    \ "sho": "ϸ",
    \ "shima": "ϭ",
    \ "shei": "ϣ",
    \ "sharp": "♯",
    \ "sigma": "σ",
    \ "simeq": "≃",
    \ "sim": "∼",
    \ "sbs": "﹨",
    \ "smallamalg": "∐",
    \ "smallsetminus": "∖",
    \ "smallsmile": "⌣",
    \ "smile": "⌣",
    \ "swarrow": "↙",
    \ "Tr": "◀",
    \ "Tb": "◀",
    \ "Tw": "◁",
    \ "Tau": "Τ",
    \ "Theta": "Θ",
    \ "TH": "Þ",
    \ "union": "∪",
    \ "undertie": "‿",
    \ "uncertainty": "⯑",
    \ "un": "∪",
    \ "ud": "↕",
    \ "ulcorner": "⌜",
    \ "ul": "↖",
    \ "urcorner": "⌝",
    \ "ur": "↗",
    \ "upsilon": "υ",
    \ "uparrow": "↑",
    \ "updownarrow": "↕",
    \ "upleftharpoon": "↿",
    \ "uplus": "⊎",
    \ "uprightharpoon": "↾",
    \ "upuparrows": "⇈",
    \ "And": "⋀",
    \ "AA": "Å",
    \ "AE": "Æ",
    \ "Alpha": "Α",
    \ "Or": "⋁",
    \ "Ox": "⨂",
    \ "OE": "Œ",
    \ "Omega": "Ω",
    \ "Omicron": "Ο",
    \ "Int": "ℤ",
    \ "Iota": "Ι",
    \ "Im": "ℑ",
    \ "Un": "⋃",
    \ "Upsilon": "Υ",
    \ "Uparrow": "⇑",
    \ "Updownarrow": "⇕",
    \ "Glb": "⨅",
    \ "Gl": "λ",
    \ "Gangia": "Ϫ",
    \ "Gamma": "Γ",
    \ "Ga": "α",
    \ "GA": "Α",
    \ "Gb": "β",
    \ "GB": "Β",
    \ "Gg": "γ",
    \ "GG": "Γ",
    \ "Gd": "δ",
    \ "GD": "Δ",
    \ "Ge": "ε",
    \ "GE": "Ε",
    \ "Gz": "ζ",
    \ "GZ": "Ζ",
    \ "Gth": "θ",
    \ "Gt": "τ",
    \ "GTH": "Θ",
    \ "GT": "Τ",
    \ "Gi": "ι",
    \ "GI": "Ι",
    \ "Gk": "κ",
    \ "GK": "Κ",
    \ "GL": "Λ",
    \ "Gm": "μ",
    \ "GM": "Μ",
    \ "Gn": "ν",
    \ "GN": "Ν",
    \ "Gx": "ξ",
    \ "GX": "Ξ",
    \ "Gr": "ρ",
    \ "GR": "Ρ",
    \ "Gs": "σ",
    \ "GS": "Σ",
    \ "Gu": "υ",
    \ "GU": "Υ",
    \ "Gf": "φ",
    \ "GF": "Φ",
    \ "Gc": "χ",
    \ "GC": "Χ",
    \ "Gp": "ψ",
    \ "GP": "Ψ",
    \ "Go": "ω",
    \ "GO": "Ω",
    \ "Lub": "⨆",
    \ "Lambda": "Λ",
    \ "Lamda": "Λ",
    \ "Leftarrow": "⇐",
    \ "Leftrightarrow": "⇔",
    \ "Letter": "✉",
    \ "Lleftarrow": "⇚",
    \ "Ll": "⋘",
    \ "Longleftarrow": "⇐",
    \ "Longleftrightarrow": "⇔",
    \ "Longrightarrow": "⇒",
    \ "Lsh": "↰",
    \ "Com": "ℂ",
    \ "Chi": "Χ",
    \ "Cap": "⋒",
    \ "Cup": "⋓",
    \ "cul": "⌜",
    \ "cuL": "⌈",
    \ "currency": "¤",
    \ "curlyeqprec": "⋞",
    \ "curlyeqsucc": "⋟",
    \ "curlypreceq": "≼",
    \ "curlyvee": "⋎",
    \ "curlywedge": "⋏",
    \ "curvearrowleft": "↶",
    \ "curvearrowright": "↷",
    \ "cur": "⌝",
    \ "cuR": "⌉",
    \ "cup": "∪",
    \ "cu": "⌜",
    \ "cll": "⌞",
    \ "clL": "⌊",
    \ "clr": "⌟",
    \ "clR": "⌋",
    \ "clubsuit": "♣",
    \ "cl": "⌞",
    \ "construction": "🚧",
    \ "cong": "≅",
    \ "con": "⬝",
    \ "complement": "∁",
    \ "comp": "∘",
    \ "com": "ℂ",
    \ "coloneq": "≔",
    \ "colon": "₡",
    \ "copyright": "©",
    \ "cdots": "⋯",
    \ "cdot": "⬝",
    \ "cib": "●",
    \ "ciw": "○",
    \ "ciO": "◯",
    \ "circeq": "≗",
    \ "circlearrowleft": "↺",
    \ "circlearrowright": "↻",
    \ "circledR": "®",
    \ "circledS": "Ⓢ",
    \ "circledast": "⊛",
    \ "circledcirc": "⊚",
    \ "circleddash": "⊝",
    \ "circ": "∘",
    \ "ci": "●",
    \ "centerdot": "·",
    \ "cent": "¢",
    \ "cedi": "₵",
    \ "celsius": "℃",
    \ "ce": "ȩ",
    \ "checkmark": "✓",
    \ "chi": "χ",
    \ "cruzeiro": "₢",
    \ "caution": "☡",
    \ "cap": "∩",
    \ "qed": "∎",
    \ "quad": " ",
    \ "bx": "⊠",
    \ "bn": "ℕ",
    \ "bz": "ℤ",
    \ "bq": "ℚ",
    \ "brokenbar": "¦",
    \ "br": "ℝ",
    \ "bc": "ℂ",
    \ "bp": "ℙ",
    \ "bb": "𝔹",
    \ "bsum": "⅀",
    \ "bub": "•",
    \ "buw": "◦",
    \ "but": "‣",
    \ "bumpeq": "≏",
    \ "bu": "•",
    \ "biohazard": "☣",
    \ "bigcap": "⋂",
    \ "bigcirc": "◯",
    \ "bigcup": "⋃",
    \ "bigstar": "★",
    \ "bigtriangledown": "▽",
    \ "bigtriangleup": "△",
    \ "bigvee": "⋁",
    \ "bigwedge": "⋀",
    \ "beta": "β",
    \ "beth": "ℶ",
    \ "between": "≬",
    \ "because": "∵",
    \ "backcong": "≌",
    \ "backepsilon": "∍",
    \ "backprime": "‵",
    \ "backsimeq": "⋍",
    \ "backsim": "∽",
    \ "barwedge": "⊼",
    \ "blacklozenge": "✦",
    \ "blacksquare": "▪",
    \ "blacksmiley": "☻",
    \ "blacktriangledown": "▾",
    \ "blacktriangleleft": "◂",
    \ "blacktriangleright": "▸",
    \ "blacktriangle": "▴",
    \ "bot": "⊥",
    \ "bowtie": "⋈",
    \ "boxminus": "⊟",
    \ "boxmid": "◫",
    \ "hcomp": "◫",
    \ "boxplus": "⊞",
    \ "boxtimes": "⊠",
    \ "join": "⋈",
    \ "reb": "▬",
    \ "rew": "▭",
    \ "real": "ℝ",
    \ "registered": "®",
    \ "re": "▬",
    \ "rbag": "⟆",
    \ "rat": "ℚ",
    \ "radioactive": "☢",
    \ "rangle": "⟩",
    \ "rq": "’",
    \ "rial": "﷼",
    \ "rightarrowtail": "↣",
    \ "rightarrow": "→",
    \ "rightharpoondown": "⇁",
    \ "rightharpoonup": "⇀",
    \ "rightleftarrows": "⇄",
    \ "rightleftharpoons": "⇌",
    \ "rightrightarrows": "⇉",
    \ "rightthreetimes": "⋌",
    \ "risingdotseq": "≓",
    \ "ruble": "₽",
    \ "rupee": "₨",
    \ "rho": "ρ",
    \ "rhd": "▷",
    \ "rceil": "⌉",
    \ "rfloor": "⌋",
    \ "rtimes": "⋊",
    \ "rdq": "”",
    \ "rdata": "》",
    \ "functor": "⥤",
    \ "fun": "λ",
    \ "frac": "¼",
    \ "frown": "⌢",
    \ "frqq": "»",
    \ "frq": "›",
    \ "female": "♀",
    \ "fei": "ϥ",
    \ "facsimile": "℻",
    \ "fallingdotseq": "≒",
    \ "flat": "♭",
    \ "flqq": "«",
    \ "flq": "‹",
    \ "forall": "∀",
    \ "Xi": "Ξ",
    \ "Nat": "ℕ",
    \ "Nu": "Ν",
    \ "Zeta": "Ζ",
    \ "Rat": "ℚ",
    \ "Real": "ℝ",
    \ "Re": "ℜ",
    \ "Rho": "Ρ",
    \ "Rightarrow": "⇒",
    \ "Rrightarrow": "⇛",
    \ "Rsh": "↱",
    \ "Fei": "Ϥ",
    \ "Frowny": "☹",
    \ "Hori": "Ϩ",
    \ "Heta": "Ͱ",
    \ "Khei": "Ϧ",
    \ "Koppa": "Ϟ",
    \ "Kappa": "Κ",
    \ "San": "Ϻ",
    \ "Sampi": "Ϡ",
    \ "Sho": "Ϸ",
    \ "Shima": "Ϭ",
    \ "Shei": "Ϣ",
    \ "Stigma": "Ϛ",
    \ "Sigma": "Σ",
    \ "Subset": "⋐",
    \ "Supset": "⋑",
    \ "Smiley": "☺",
    \ "Psi": "Ψ",
    \ "Phi": "Φ",
    \ "Pi": "Π",
    \ "MiA": "𝐴",
    \ "MiB": "𝐵",
    \ "MiC": "𝐶",
    \ "MiD": "𝐷",
    \ "MiE": "𝐸",
    \ "MiF": "𝐹",
    \ "MiG": "𝐺",
    \ "MiH": "𝐻",
    \ "MiI": "𝐼",
    \ "MiJ": "𝐽",
    \ "MiK": "𝐾",
    \ "MiL": "𝐿",
    \ "MiM": "𝑀",
    \ "MiN": "𝑁",
    \ "MiO": "𝑂",
    \ "MiP": "𝑃",
    \ "MiQ": "𝑄",
    \ "MiR": "𝑅",
    \ "MiS": "𝑆",
    \ "MiT": "𝑇",
    \ "MiU": "𝑈",
    \ "MiV": "𝑉",
    \ "MiW": "𝑊",
    \ "MiX": "𝑋",
    \ "MiY": "𝑌",
    \ "MiZ": "𝑍",
    \ "Mia": "𝑎",
    \ "Mib": "𝑏",
    \ "Mic": "𝑐",
    \ "Mid": "𝑑",
    \ "Mie": "𝑒",
    \ "Mif": "𝑓",
    \ "Mig": "𝑔",
    \ "Mii": "𝑖",
    \ "Mij": "𝑗",
    \ "Mik": "𝑘",
    \ "Mil": "𝑙",
    \ "Mim": "𝑚",
    \ "Min": "𝑛",
    \ "Mio": "𝑜",
    \ "Mip": "𝑝",
    \ "Miq": "𝑞",
    \ "Mir": "𝑟",
    \ "Mis": "𝑠",
    \ "Mit": "𝑡",
    \ "Miu": "𝑢",
    \ "Miv": "𝑣",
    \ "Miw": "𝑤",
    \ "Mix": "𝑥",
    \ "Miy": "𝑦",
    \ "Miz": "𝑧",
    \ "MIA": "𝑨",
    \ "MIB": "𝑩",
    \ "MIC": "𝑪",
    \ "MID": "𝑫",
    \ "MIE": "𝑬",
    \ "MIF": "𝑭",
    \ "MIG": "𝑮",
    \ "MIH": "𝑯",
    \ "MII": "𝑰",
    \ "MIJ": "𝑱",
    \ "MIK": "𝑲",
    \ "MIL": "𝑳",
    \ "MIM": "𝑴",
    \ "MIN": "𝑵",
    \ "MIO": "𝑶",
    \ "MIP": "𝑷",
    \ "MIQ": "𝑸",
    \ "MIR": "𝑹",
    \ "MIS": "𝑺",
    \ "MIT": "𝑻",
    \ "MIU": "𝑼",
    \ "MIV": "𝑽",
    \ "MIW": "𝑾",
    \ "MIX": "𝑿",
    \ "MIY": "𝒀",
    \ "MIZ": "𝒁",
    \ "MIa": "𝒂",
    \ "MIb": "𝒃",
    \ "MIc": "𝒄",
    \ "MId": "𝒅",
    \ "MIe": "𝒆",
    \ "MIf": "𝒇",
    \ "MIg": "𝒈",
    \ "MIh": "𝒉",
    \ "MIi": "𝒊",
    \ "MIj": "𝒋",
    \ "MIk": "𝒌",
    \ "MIl": "𝒍",
    \ "MIm": "𝒎",
    \ "MIn": "𝒏",
    \ "MIo": "𝒐",
    \ "MIp": "𝒑",
    \ "MIq": "𝒒",
    \ "MIr": "𝒓",
    \ "MIs": "𝒔",
    \ "MIt": "𝒕",
    \ "MIu": "𝒖",
    \ "MIv": "𝒗",
    \ "MIw": "𝒘",
    \ "MIx": "𝒙",
    \ "MIy": "𝒚",
    \ "MIz": "𝒛",
    \ "McA": "𝒜",
    \ "McB": "ℬ",
    \ "McC": "𝒞",
    \ "McD": "𝒟",
    \ "McE": "ℰ",
    \ "McF": "ℱ",
    \ "McG": "𝒢",
    \ "McH": "ℋ",
    \ "McI": "ℐ",
    \ "McJ": "𝒥",
    \ "McK": "𝒦",
    \ "McL": "ℒ",
    \ "McM": "ℳ",
    \ "McN": "𝒩",
    \ "McO": "𝒪",
    \ "McP": "𝒫",
    \ "McQ": "𝒬",
    \ "McR": "ℛ",
    \ "McS": "𝒮",
    \ "McT": "𝒯",
    \ "McU": "𝒰",
    \ "McV": "𝒱",
    \ "McW": "𝒲",
    \ "McX": "𝒳",
    \ "McY": "𝒴",
    \ "McZ": "𝒵",
    \ "Mca": "𝒶",
    \ "Mcb": "𝒷",
    \ "Mcc": "𝒸",
    \ "Mcd": "𝒹",
    \ "Mce": "ℯ",
    \ "Mcf": "𝒻",
    \ "Mcg": "ℊ",
    \ "Mch": "𝒽",
    \ "Mci": "𝒾",
    \ "Mcj": "𝒿",
    \ "Mck": "𝓀",
    \ "Mcl": "𝓁",
    \ "Mcm": "𝓂",
    \ "Mcn": "𝓃",
    \ "Mco": "ℴ",
    \ "Mcp": "𝓅",
    \ "Mcq": "𝓆",
    \ "Mcr": "𝓇",
    \ "Mcs": "𝓈",
    \ "Mct": "𝓉",
    \ "Mcu": "𝓊",
    \ "Mcv": "𝓋",
    \ "Mcw": "𝓌",
    \ "Mcx": "𝓍",
    \ "Mcy": "𝓎",
    \ "Mcz": "𝓏",
    \ "MCA": "𝓐",
    \ "MCB": "𝓑",
    \ "MCC": "𝓒",
    \ "MCD": "𝓓",
    \ "MCE": "𝓔",
    \ "MCF": "𝓕",
    \ "MCG": "𝓖",
    \ "MCH": "𝓗",
    \ "MCI": "𝓘",
    \ "MCJ": "𝓙",
    \ "MCK": "𝓚",
    \ "MCL": "𝓛",
    \ "MCM": "𝓜",
    \ "MCN": "𝓝",
    \ "MCO": "𝓞",
    \ "MCP": "𝓟",
    \ "MCQ": "𝓠",
    \ "MCR": "𝓡",
    \ "MCS": "𝓢",
    \ "MCT": "𝓣",
    \ "MCU": "𝓤",
    \ "MCV": "𝓥",
    \ "MCW": "𝓦",
    \ "MCX": "𝓧",
    \ "MCY": "𝓨",
    \ "MCZ": "𝓩",
    \ "MCa": "𝓪",
    \ "MCb": "𝓫",
    \ "MCc": "𝓬",
    \ "MCd": "𝓭",
    \ "MCe": "𝓮",
    \ "MCf": "𝓯",
    \ "MCg": "𝓰",
    \ "MCh": "𝓱",
    \ "MCi": "𝓲",
    \ "MCj": "𝓳",
    \ "MCk": "𝓴",
    \ "MCl": "𝓵",
    \ "MCm": "𝓶",
    \ "MCn": "𝓷",
    \ "MCo": "𝓸",
    \ "MCp": "𝓹",
    \ "MCq": "𝓺",
    \ "MCr": "𝓻",
    \ "MCs": "𝓼",
    \ "MCt": "𝓽",
    \ "MCu": "𝓾",
    \ "MCv": "𝓿",
    \ "MCw": "𝔀",
    \ "MCx": "𝔁",
    \ "MCy": "𝔂",
    \ "MCz": "𝔃",
    \ "MfA": "𝔄",
    \ "MfB": "𝔅",
    \ "MfC": "ℭ",
    \ "MfD": "𝔇",
    \ "MfE": "𝔈",
    \ "MfF": "𝔉",
    \ "MfG": "𝔊",
    \ "MfH": "ℌ",
    \ "MfI": "ℑ",
    \ "MfJ": "𝔍",
    \ "MfK": "𝔎",
    \ "MfL": "𝔏",
    \ "MfM": "𝔐",
    \ "MfN": "𝔑",
    \ "MfO": "𝔒",
    \ "MfP": "𝔓",
    \ "MfQ": "𝔔",
    \ "MfR": "ℜ",
    \ "MfS": "𝔖",
    \ "MfT": "𝔗",
    \ "MfU": "𝔘",
    \ "MfV": "𝔙",
    \ "MfW": "𝔚",
    \ "MfX": "𝔛",
    \ "MfY": "𝔜",
    \ "MfZ": "ℨ",
    \ "Mfa": "𝔞",
    \ "Mfb": "𝔟",
    \ "Mfc": "𝔠",
    \ "Mfd": "𝔡",
    \ "Mfe": "𝔢",
    \ "Mff": "𝔣",
    \ "Mfg": "𝔤",
    \ "Mfh": "𝔥",
    \ "Mfi": "𝔦",
    \ "Mfj": "𝔧",
    \ "Mfk": "𝔨",
    \ "Mfl": "𝔩",
    \ "Mfm": "𝔪",
    \ "Mfn": "𝔫",
    \ "Mfo": "𝔬",
    \ "Mfp": "𝔭",
    \ "Mfq": "𝔮",
    \ "Mfr": "𝔯",
    \ "Mfs": "𝔰",
    \ "Mft": "𝔱",
    \ "Mfu": "𝔲",
    \ "Mfv": "𝔳",
    \ "Mfw": "𝔴",
    \ "Mfx": "𝔵",
    \ "Mfy": "𝔶",
    \ "Mfz": "𝔷",
    \ "yen": "¥",
    \ "varrho": "ϱ",
    \ "varkappa": "ϰ",
    \ "varkai": "ϗ",
    \ "varpi": "ϖ",
    \ "varphi": "ϕ",
    \ "varprime": "′",
    \ "varpropto": "∝",
    \ "vartheta": "ϑ",
    \ "vartriangleleft": "⊲",
    \ "vartriangleright": "⊳",
    \ "varbeta": "ϐ",
    \ "varsigma": "ς",
    \ "veebar": "⊻",
    \ "vee": "∨",
    \ "ve": "ě",
    \ "vE": "Ě",
    \ "vdash": "⊢",
    \ "vdots": "⋮",
    \ "vd": "ď",
    \ "vDash": "⊨",
    \ "vD": "Ď",
    \ "vc": "č",
    \ "vC": "Č",
    \ "koppa": "ϟ",
    \ "kip": "₭",
    \ "ki": "į",
    \ "kI": "Į",
    \ "kelvin": "K",
    \ "kappa": "κ",
    \ "khei": "ϧ",
    \ "warning": "⚠",
    \ "won": "₩",
    \ "wedge": "∧",
    \ "wp": "℘",
    \ "wr": "≀",
    \ "Dei": "Ϯ",
    \ "Delta": "Δ",
    \ "Digamma": "Ϝ",
    \ "Diamond": "◇",
    \ "Downarrow": "⇓",
    \ "DH": "Ð",
    \ "zeta": "ζ",
    \ "Eta": "Η",
    \ "Epsilon": "Ε",
    \ "Beta": "Β",
    \ "Box": "□",
    \ "Bumpeq": "≎",
    \ "bbA": "𝔸",
    \ "bbB": "𝔹",
    \ "bbC": "ℂ",
    \ "bbD": "𝔻",
    \ "bbE": "𝔼",
    \ "bbF": "𝔽",
    \ "bbG": "𝔾",
    \ "bbH": "ℍ",
    \ "bbI": "𝕀",
    \ "bbJ": "𝕁",
    \ "bbK": "𝕂",
    \ "bbL": "𝕃",
    \ "bbM": "𝕄",
    \ "bbN": "ℕ",
    \ "bbO": "𝕆",
    \ "bbP": "ℙ",
    \ "bbQ": "ℚ",
    \ "bbR": "ℝ",
    \ "bbS": "𝕊",
    \ "bbT": "𝕋",
    \ "bbU": "𝕌",
    \ "bbV": "𝕍",
    \ "bbW": "𝕎",
    \ "bbX": "𝕏",
    \ "bbY": "𝕐",
    \ "bbZ": "ℤ",
    \ "bbk": "𝕜",
    \ "nnreal": "ℝ≥0",
    \ "Zsqrt": "ℤ√",
    \ "zsqrtd": "ℤ√",
    \ "liel": "⁅",
    \ "bracketl": "⁅",
    \ "lier": "⁆",
    \ "bracketr": "⁆",
    \ "nhds": "𝓝",
    \ "nbhds": "𝓝",
    \ "X": "×",
    \ "vectorproduct": "⨯",
    \ "crossproduct": "⨯",
    \ "coprod": "⨿",
    \ "sigmaobj": "∐",
    \ "bigcoprod": "∐",
    \ "xf": "×ᶠ",
    \ "exf": "∃ᶠ",
    \ "Yot": "Ϳ",
    \ "Join": "⋈",
    \ "Vdash": "⊩",
    \ "Vert": "‖",
    \ "Vvdash": "⊪",
    \ }
" }}}

" hack to make abbreviations work
setlocal iskeyword+=\

for marker_symbol_pair in items(b:lean_mappings)
    execute 'inoreabbrev <buffer> \' . marker_symbol_pair[0] . ' ' . marker_symbol_pair[1]
endfor