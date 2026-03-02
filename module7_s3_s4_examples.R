# Module 7: S3 vs S4 Examples
# Dataset choice: mtcars

# ----------------------------
# Step 1: Load and inspect data
# ----------------------------
data("mtcars")
head(mtcars, 6)

# What OO system is mtcars?
class(mtcars)         # S3 class
isS4(mtcars)          # should be FALSE (mtcars is not S4)

# Base type checks
typeof(mtcars)        # underlying type
mode(mtcars)
str(mtcars)

# ----------------------------
# Step 2: Generic functions on the dataset
# ----------------------------
# summary() is a generic function that dispatches based on class
summary(mtcars)

# You can confirm methods for summary
methods("summary")

# ----------------------------
# Step 3A: S3 example
# ----------------------------
student_s3 <- list(name = "Myself", age = 20, GPA = 3.5)
class(student_s3) <- "studentS3"

print.studentS3 <- function(x) {
  cat("S3 Student Object\n")
  cat("Name:", x$name, "\n")
  cat("Age:", x$age, "\n")
  cat("GPA:", x$GPA, "\n")
}

summary.studentS3 <- function(object, ...) {
  paste0(object$name, " is ", object$age, " years old with GPA ", object$GPA)
}

# Test S3 methods
student_s3
print(student_s3)
summary(student_s3)

# Check OO system + base type
class(student_s3)     # S3 class name
isS4(student_s3)      # FALSE
typeof(student_s3)    # list
str(student_s3)

# ----------------------------
# Step 3B: S4 example
# ----------------------------
setClass(
  "studentS4",
  slots = c(
    name = "character",
    age  = "numeric",
    GPA  = "numeric"
  )
)

student_s4 <- new("studentS4", name = "Myself", age = 20, GPA = 3.5)

# Show S4 object
student_s4

# S4 checks
class(student_s4)
isS4(student_s4)

# Access slots
student_s4@name
student_s4@age
student_s4@GPA

# Optional: define an S4 method for show()
setMethod("show", "studentS4", function(object) {
  cat("S4 Student Object\n")
  cat("Name:", object@name, "\n")
  cat("Age:", object@age, "\n")
  cat("GPA:", object@GPA, "\n")
})

# Test the show method
student_s4
