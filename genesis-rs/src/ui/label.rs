#[derive(Debug, Clone)]
pub struct Label {
    text: Option<String>,
    font: Option<crate::data::font::Font>,
    text_alignment: Option<TextAlignment>,
    line_break_mode: Option<LineBreakMode>,
}


pub enum TableViewDelegate {}


#[derive(Debug, Clone, Copy)]
pub enum TextAlignment {
    /// Visually left aligned
    Left,
    /// Visually right aligned
    Right,
    /// Visually centered
    Center,
    /// Fully-justified. The last line in a paragraph is natural-aligned.
    Justified,
    /// Indicates the default alignment for script
    Natural,
}

#[derive(Debug, Clone, Copy)]
pub enum LineBreakMode {
    /// Wrap at word boundaries, default
    ByWordWrapping,
    /// Wrap at character boundaries
    ByCharWrapping,
    /// Simply clip
    ByClipping,
    /// Truncate at head of line: "...wxyz"
    ByTruncatingHead,
    /// Truncate at tail of line: "abcd..."
    ByTruncatingTail,
    /// Truncate middle of line:  "ab...yz"
    ByTruncatingMiddle,
}