use serde::{Serialize, Deserialize, de::DeserializeOwned};
use crate::data::color::{Color, ColorMap};

pub trait UXCoding {
    
}


pub trait UXObject {
    
}


pub trait UXResponder: UXObject {

}

pub trait UXAppearance {

}

pub trait UXAppearanceContainer {

}

pub trait UXDynamicItem {

}

pub trait UXTraitEnvironment {

}

pub trait UXCoordinateSpace {
    
}

pub trait UXFocusItem {

}

pub trait UXFocusItemContainer {

}

pub trait UXLayerDelegate {

}

pub trait UXContentContainer {

}

pub trait UXFocusEnvironment {

}


#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Point {
    pub x: f32,
    pub y: f32,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Size {
    pub width: f32,
    pub height: f32,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Rect {
    pub origin: Point,
    pub size: Size,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UXLayer {
    pub background_color: Option<ColorMap>,
    pub corner_radius: Option<f32>,
    pub is_hidden: Option<bool>,
    pub bounds: Option<Rect>,
    pub frame: Option<Rect>,
    pub position: Option<Point>,
    pub z_position: Option<isize>,
    pub mask: Option<Box<UXLayer>>,
}

pub trait Layerable {
    fn sublayers(&self) -> &[UXLayer];
    fn insert_sublayer(&mut self, layer: UXLayer, index: usize);
    fn add_sublayer(&mut self, layer: UXLayer);
}

pub trait BaseView: UXResponder + UXCoding + UXAppearance + UXAppearanceContainer + UXDynamicItem + UXTraitEnvironment + UXCoordinateSpace + UXFocusItem + UXFocusItemContainer + UXLayerDelegate {
    fn can_become_focused(&self) -> Option<bool> {None}
    fn set_needs_display(&mut self) {}
    fn set_alpha(&self, value: f32);
    fn set_background_color(&self, color: ColorMap);
}

pub trait HasSubviews {
    fn add_subview(&self, view: impl BaseView);
}

pub trait ViewController: UXResponder + UXCoding + UXAppearanceContainer + UXTraitEnvironment + UXContentContainer + UXFocusEnvironment {
    fn on_load(&self);
    fn on_disappear(&self);
}

pub trait Label: BaseView {
    fn text(&self) -> &str;
}

pub trait TableView: BaseView {

}

pub trait TableViewCell: BaseView {
    fn content_view() -> Option<&'static dyn BaseView> {None}
    fn text_label() -> Option<&'static dyn Label> {None}
}



