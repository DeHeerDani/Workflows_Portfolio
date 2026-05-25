# ~/Workflows/Workflows_Portfolio/Opdracht_2_Vrije_Opdracht/Data/PetImages/ (Cat) (Dog)
# Cats vs Dogs classification using CNN
# Based on Fashion MNIST tutorial but applied to custom dataset

install.packages("jpeg")

library(tidyverse)
library(keras3)
library(tensorflow)
library(reticulate)
library(jpeg)
library(grid)



normalizePath("~/Workflows/Workflows_Portfolio/Opdracht_2_Vrije_Opdracht/Data/Training")
dataset_path <- "/home/dani.pfeijffer/Workflows/Workflows_Portfolio/Opdracht_2_Vrije_Opdracht/Data/Training"

files <- list.files(dataset_path, recursive = TRUE, full.names = TRUE)

bad_files <- c()
for (f in files) {
  img <- try(readJPEG(f), silent = TRUE)
  if (inherits(img, "try-error")) {
    bad_files <- c(bad_files, f)
  }
}

file.remove(bad_files)

train_ds <- image_dataset_from_directory(
  dataset_path,
  image_size = c(64, 64),
  batch_size = 32,
  validation_split = 0.2,
  subset = "training",
  seed = 123
)


val_ds <- image_dataset_from_directory(
  dataset_path,
  image_size = c(64, 64),
  batch_size = 32,
  validation_split = 0.2,
  subset = "validation",
  seed = 123
)




iterator <- as_iterator(train_ds)

batch <- reticulate::iter_next(iterator)

images <- batch[[1]]
labels <- batch[[2]]

par(mfrow = c(3,3))
for (i in 1:9) {
  img <- images[i,,,]
  plot(as.raster(img / 255))
  title(
    main = ifelse(labels[i] == 0, "Cat", "Dog")
  )
}


# maken van het model.
model <- keras_model_sequential() %>%
  layer_rescaling(scale = 1/255, input_shape = c(64, 64, 3)) %>%
  layer_conv_2d(filters = 32, kernel_size = 3, activation = "relu") %>%
  layer_max_pooling_2d() %>%
  layer_conv_2d(filters = 64, kernel_size = 3, activation = "relu") %>%
  layer_max_pooling_2d() %>%
  layer_flatten() %>%
  layer_dense(units = 64, activation = "relu") %>%
  layer_dense(units = 1, activation = "sigmoid")


summary(model)



model %>% compile(
  optimizer = "adam",
  loss = "binary_crossentropy",
  metrics = c("accuracy")
)


model %>% fit(train_ds, validation_data = val_ds, epochs = 5, verbose = 2)


# nu we het model getraint hebben gaan we kijken naar de tsest data set. en wat de accuracy/loss daarvan is.
score <- model %>% evaluate(val_ds, verbose = 0)

cat("Validation loss:", score[["loss"]], "\n")
cat("Validation accuracy:", score[["accuracy"]], "\n")


predictions <- model %>% predict(val_ds)

predictions[1, ]

predicted_label <- ifelse(predictions[1, ] > 0.5, 1, 0)
predicted_label


iterator <- as_iterator(val_ds)
batch <- reticulate::iter_next(iterator)

images <- batch[[1]]
labels <- batch[[2]]


predictions <- model %>% predict(images[1,,, drop = FALSE])
predictions
predicted_label <- ifelse(predictions[1, ] > 0.5, 1, 0)
predicted_label




par(mfrow = c(3,3), mar = c(1,1,2,1))

iterator <- as_iterator(val_ds)
batch <- reticulate::iter_next(iterator)

images <- batch[[1]]
labels <- batch[[2]]

predictions <- model %>% predict(images)

for (i in 1:9) {
  img <- images[i,,,]
  pred_value <- predictions[i, 1]
  pred_label <- ifelse(pred_value > 0.5, 1, 0)
  true_label <- as.numeric(labels[i])
  col <- ifelse(pred_label == true_label, "darkgreen", "red")
  plot(as.raster(img / 255))
  title(
    main = paste0(
      ifelse(pred_label == 1, "Dog", "Cat"),
      " (", round(pred_value, 2), ")"
    ),
    col.main = col
  )
}
