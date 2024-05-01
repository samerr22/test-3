import bcryptjs from "bcryptjs";
import { errorHandle } from "../utils/error.js";
import User from "../models/user.model.js";
import Shedul from "../models/Shedul.model.js";

export const test = (req, res) => {
  res.json({ message: "api is worker" });
};






export const signout = (req, res, next) => {
  try {
    res
      .clearCookie('access_token')
      .status(200)
      .json('User has been signed out');
  } catch (error) {
    next(error);
  }
};

//shedul create
export const Schedulcreate = async (req, res, next) => {
  

  const { currentId, name, Email, phone, date,time } = req.body;

  const newShedul = new Shedul({
    currentId,
    name,
    Email,
    phone,
    date,
    time
  });
  try {
    const savedShedul = await newShedul.save();
    res.status(201).json(savedShedul);
  } catch (error) {
    next(error);
  }
};


//currret user shedul get
export const getschedul = async (req, res, next) => {
    
  try {
    const { currentId } = req.params;
    console.log(currentId)

    
    const shedul = await Shedul.find({ currentId });
    console.log(shedul)

    

    
    res.json(shedul);

  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Server Error' });
  }
};

//get all shedul
export const allgetSchedul = async (req, res, next) => {

  if (!req.user.isAdmin) {
    return next(errorHandle(403, "You are not allowed to delete this shedul"));
  }

  
  try {

    

    const isAdmin = req.user.isAdmin;

    if (isAdmin) {
      console.log(isAdmin);

      const shadul = await Shedul.find();

      if (shadul.length > 0) {
        res.json({
          message: "shadul details retrieved successfully",
          shadul,
        });
      } else {
        return next(errorHandle(404, " shadul not fonud "));
      }
    }
  } catch (error) {
    console.log(error.message);

    next(error);
  }
};

//update shadul
export const updateschedul = async (req, res, next) => {
 
  try {
    const updateSchedul = await Shedul.findByIdAndUpdate(
      req.params.schedulId,
      {
        $set: {
          currentId: req.body.currentId,
          name: req.body.name,
          Email: req.body.Email,
          phone: req.body.phone,
          date: req.body.date,
          time: req.body.time
        },
      },
      { new: true }
    );
    res.status(200).json(updateSchedul);
  } catch (error) {
    next(error);
  }
};


//cancel shedul
export const deleteSchedul = async (req, res, next) => {
 
  try {
    await User.findByIdAndDelete(req.params.scheduId);
    res.status(200).json('shedul has been deleted');
  } catch (error) {
    next(error);
  }
};





