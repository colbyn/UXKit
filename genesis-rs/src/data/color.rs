use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Color {

}


#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ColorMap {
    light_mode: Color,
    dark_mode: Color,
}