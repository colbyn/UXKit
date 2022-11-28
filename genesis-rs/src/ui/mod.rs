pub mod label;
pub mod table;
pub mod font;
pub mod view;

pub trait Viewable {
    type Msg;
}

pub struct View {
    children: Vec<View>,
}



