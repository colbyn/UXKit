#[derive(Debug, Clone, Copy, PartialEq)]
pub enum Design {
    Default,
    Serif,
    Rounded,
    Monospaced,
}


#[derive(Debug, Clone, Copy, PartialEq)]
pub enum Weight {
    UltraLight,
    Thin,
    Light,
    Regular,
    Medium,
    Semibold,
    Bold,
    Heavy,
    Black,
}

#[derive(Debug, Clone)]
pub struct Font {
    design: Option<Design>,
    weight: Option<Weight>,
    size: Option<f32>,
}
