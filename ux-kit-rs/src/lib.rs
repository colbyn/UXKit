#![allow(unused)]
pub mod c_ffi_utils;

use std::collections::HashMap;
use std::any::Any;
use serde::{Serialize, Deserialize};
use uuid::Uuid;


pub trait Identifiable {
    fn identifier(&self) -> Uuid;
}

#[derive(Debug, Clone)]
pub struct View {

}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Color {

}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ForegroundColor {

}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum NavStackCmd {
    Pop
}


#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Alpha {
    value: usize
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Beta {
    value: usize
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Gamma {
    value: usize
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Downstream {}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ColorMap {
    light_mode: Color,
    dark_mode: Color,
}

pub trait Component {
    type Model;
    fn init() -> Self::Model;
}

